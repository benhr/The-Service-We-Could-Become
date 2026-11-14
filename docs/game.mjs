// Plays an episode in the browser with inkjs, and handles the save code.
// No analytics, no cookies, no network calls beyond loading the episode file.
import { encode, decode, DONE, TRACKS, FLAGS } from './codec.mjs';

const LEDGER = [...DONE, ...TRACKS.map(t => t.name), ...FLAGS.map(f => f[0])];
const TITLES = {
  ep1: 'Episode 1: Four partners, one inherited program',
  ep3_preview: 'Episode 3: opening only',
};

const $ = id => document.getElementById(id);
const home = $('home'), play = $('play'), storyEl = $('story'), choicesEl = $('choices'), endingEl = $('ending');
const codeInput = $('code-input'), codeMsg = $('code-message');

let story = null, current = null, startState = null, lastCode = '', docBlock = null;

// Text size, remembered for this visit only if storage is available.
let scale = 1;
try { scale = Number(sessionStorage.getItem('swc-scale')) || 1; } catch (e) { /* storage unavailable */ }
const applyScale = () => {
  document.documentElement.style.fontSize = (100 * scale) + '%';
  try { sessionStorage.setItem('swc-scale', String(scale)); } catch (e) { /* ignore */ }
};
applyScale();
$('text-smaller').addEventListener('click', () => { scale = Math.max(0.85, +(scale - 0.1).toFixed(2)); applyScale(); });
$('text-larger').addEventListener('click', () => { scale = Math.min(1.6, +(scale + 0.1).toFixed(2)); applyScale(); });

function showHome() {
  play.hidden = true; home.hidden = false; $('tools').hidden = true;
  if (location.hash) history.replaceState(null, '', location.pathname);
  $('home-title').focus?.();
  window.scrollTo(0, 0);
}

async function start(ep, ledgerState) {
  const res = await fetch(ep + '.json');
  const json = await res.json();
  story = new inkjs.Story(json);
  current = ep;
  startState = ledgerState || null;
  if (ledgerState) {
    for (const k of LEDGER) story.variablesState[k] = ledgerState[k];
    story.variablesState['code_loaded'] = true;
  }
  storyEl.innerHTML = ''; choicesEl.innerHTML = ''; endingEl.hidden = true; docBlock = null; promptCount = 0;
  $('episode-title').textContent = TITLES[ep] || ep;
  home.hidden = true; play.hidden = false; $('tools').hidden = false;
  history.replaceState(null, '', '#' + ep);
  window.scrollTo(0, 0);
  step(true);
}

// Each piece of text is a row on the reference grid: the text in the primary
// column, and any label (who a document is from, a question number) in the margin.
let promptCount = 0;

function row(marginText, extraClass) {
  const r = document.createElement('div');
  r.className = 'row' + (extraClass ? ' ' + extraClass : '');
  const p = document.createElement('div'); p.className = 'p';
  const m = document.createElement('div'); m.className = 'm';
  if (marginText) m.textContent = marginText;
  r.append(p, m);
  storyEl.appendChild(r);
  return p;
}

function para(parent, text, cls) {
  const el = document.createElement('p');
  el.textContent = text;
  if (cls) el.className = cls;
  parent.appendChild(el);
  return el;
}

// Typographic quotes and apostrophes, so the ink source can use plain ones.
function smart(t) {
  return t
    .replace(/(^|[\s(\[])"/g, '$1\u201C').replace(/"/g, '\u201D')
    .replace(/(^|[\s(\[])'/g, '$1\u2018').replace(/'/g, '\u2019');
}

function render(raw, tags) {
  const text = smart(raw);
  const tag = tags[0] || '';
  if (tag === 'h') {
    docBlock = null;
    const h = document.createElement('h2'); h.textContent = text;
    row('').appendChild(h);
    return h;
  }
  if (tag === 'doc-head') {
    const cell = row(text, 'docrow');
    docBlock = document.createElement('div'); docBlock.className = 'doc';
    cell.appendChild(docBlock);
    return cell.parentElement;
  }
  if (tag === 'doc') {
    if (!docBlock) { docBlock = document.createElement('div'); docBlock.className = 'doc'; row('', 'docrow').appendChild(docBlock); }
    return para(docBlock, text);
  }
  docBlock = null;
  if (tag === 'placeholder') return para(row('Placeholder'), text, 'placeholder');
  if (tag === 'prompt') { promptCount++; return para(row('Question ' + promptCount), text, 'prompt'); }
  if (tag === 'quiet') return para(row(''), text, 'quiet');
  return para(row(''), text, 'narr');
}

function step(first) {
  let firstNew = null;
  while (story.canContinue) {
    const text = story.Continue().trim();
    if (!text) continue;
    const el = render(text, story.currentTags || []);
    if (!firstNew) firstNew = el;
  }
  choicesEl.innerHTML = '';
  story.currentChoices.forEach((choice, i) => {
    const b = document.createElement('button');
    b.type = 'button'; b.className = 'btn'; b.textContent = smart(choice.text);
    b.addEventListener('click', () => choose(i, choice.text));
    choicesEl.appendChild(b);
  });
  if (story.currentChoices.length === 0) finish();
  if (firstNew && !first) {
    firstNew.setAttribute('tabindex', '-1');
    firstNew.focus({ preventScroll: true });
    firstNew.scrollIntoView({ block: 'start', behavior: 'smooth' });
  }
}

function choose(i, text) {
  docBlock = null;
  para(row('You chose'), smart(text), 'chosen');
  story.ChooseChoiceIndex(i);
  step(false);
}

function finish() {
  if (current !== 'ep1') {
    const p = document.createElement('p');
    const b = document.createElement('button'); b.type = 'button'; b.className = 'btn'; b.textContent = 'Back to the episode list';
    b.addEventListener('click', showHome); p.appendChild(b); choicesEl.appendChild(p);
    return;
  }
  const s = {};
  for (const k of LEDGER) s[k] = story.variablesState[k];
  lastCode = encode(s);
  $('save-code').textContent = lastCode;
  $('copy-message').textContent = '';
  endingEl.hidden = false;
}

$('copy-code').addEventListener('click', async () => {
  const msg = $('copy-message');
  try { await navigator.clipboard.writeText(lastCode); msg.textContent = 'Copied'; }
  catch (e) {
    const r = document.createRange(); r.selectNodeContents($('save-code'));
    const sel = getSelection(); sel.removeAllRanges(); sel.addRange(r);
    msg.textContent = 'The code is selected. Use your device to copy it.';
  }
});

$('go-ep3').addEventListener('click', () => {
  codeInput.value = lastCode;
  const d = decode(lastCode);
  start('ep3_preview', d.ok ? d.state : null);
});
$('back-home').addEventListener('click', showHome);
$('home-link').addEventListener('click', e => { e.preventDefault(); showHome(); });
$('restart').addEventListener('click', () => start(current, startState));

codeInput.addEventListener('input', () => {
  codeMsg.textContent = ''; codeMsg.className = 'message';
});

document.querySelectorAll('[data-start]').forEach(btn => btn.addEventListener('click', () => {
  const ep = btn.dataset.start;
  if (ep === 'ep3_preview' && codeInput.value.trim()) {
    const d = decode(codeInput.value);
    if (!d.ok) {
      codeMsg.textContent = d.error + ' Clear the box to start without a code.';
      codeMsg.className = 'message error';
      codeInput.focus();
      return;
    }
    start(ep, d.state);
    return;
  }
  start(ep, null);
}));

// Open straight into an episode from a link such as index.html#ep1
const hash = location.hash.replace('#', '');
if (TITLES[hash]) start(hash, null);
