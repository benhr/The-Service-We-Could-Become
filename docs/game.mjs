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
  storyEl.innerHTML = ''; choicesEl.innerHTML = ''; endingEl.hidden = true; docBlock = null;
  $('episode-title').textContent = TITLES[ep] || ep;
  home.hidden = true; play.hidden = false; $('tools').hidden = false;
  history.replaceState(null, '', '#' + ep);
  window.scrollTo(0, 0);
  step(true);
}

function add(el) { storyEl.appendChild(el); return el; }

function render(text, tags) {
  const tag = tags[0] || '';
  if (tag === 'h') {
    docBlock = null;
    const h = document.createElement('h2'); h.textContent = text; return add(h);
  }
  if (tag === 'doc-head') {
    docBlock = add(document.createElement('div')); docBlock.className = 'doc';
    const h = document.createElement('h3'); h.textContent = text; docBlock.appendChild(h); return docBlock;
  }
  if (tag === 'doc') {
    if (!docBlock) { docBlock = add(document.createElement('div')); docBlock.className = 'doc'; }
    const p = document.createElement('p'); p.textContent = text; docBlock.appendChild(p); return p;
  }
  docBlock = null;
  const p = document.createElement('p'); p.textContent = text;
  if (['placeholder', 'prompt', 'quiet'].includes(tag)) p.className = tag;
  return add(p);
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
    b.type = 'button'; b.textContent = choice.text;
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
  const p = document.createElement('p'); p.className = 'chosen'; p.textContent = text; add(p);
  story.ChooseChoiceIndex(i);
  step(false);
}

function finish() {
  if (current !== 'ep1') {
    const p = document.createElement('p');
    const b = document.createElement('button'); b.type = 'button'; b.textContent = 'Back to episodes';
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
  try { await navigator.clipboard.writeText(lastCode); msg.textContent = 'Copied.'; }
  catch (e) {
    const r = document.createRange(); r.selectNodeContents($('save-code'));
    const sel = getSelection(); sel.removeAllRanges(); sel.addRange(r);
    msg.textContent = 'Selected. Copy it with your device’s copy command.';
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
      codeMsg.textContent = d.error + ' You can clear the box and start without a code.';
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
