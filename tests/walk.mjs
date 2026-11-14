// Automated playthroughs. Walks every choice path in Module 1 and checks that each
// reaches the end without errors, tracks stay within 0 to 7, the second look appears
// at most once, and the save code round-trips. Then plays the Module 2 opening with
// codes from every Module 1 ending.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { Story } from 'inkjs';
import { encode, decode, defaults, TRACKS, DONE, FLAGS } from '../docs/codec.mjs';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const load = ep => JSON.parse(fs.readFileSync(path.join(root, 'docs', ep + '.json'), 'utf8'));
const LEDGER = [...DONE, ...TRACKS.map(t => t.name), ...FLAGS.map(f => f[0])];

const problems = [];
const endings = new Map();
const outcomes = new Map();
let paths = 0, maxWords = 0, maxPath = null;

function readLedger(story) {
  const s = {};
  for (const k of LEDGER) s[k] = story.variablesState[k];
  return s;
}

function walk(story, trail, words) {
  while (story.canContinue) {
    const line = story.Continue();
    words += line.split(/\s+/).filter(Boolean).length;
  }
  if (story.currentErrors && story.currentErrors.length) problems.push({ trail, errors: story.currentErrors });
  const choices = story.currentChoices;
  if (choices.length === 0) {
    paths++;
    if (words > maxWords) { maxWords = words; maxPath = trail; }
    const s = readLedger(story);
    for (const t of TRACKS) if (s[t.name] < 0 || s[t.name] > 7) problems.push({ trail, error: `${t.name}=${s[t.name]}` });
    if (!s.done_m1) problems.push({ trail, error: 'ended without done_m1' });
    if (!s.nav_fate) problems.push({ trail, error: 'ended without nav_fate' });
    if (!s.m1_board) problems.push({ trail, error: 'ended without m1_board' });
    const navs = story.variablesState['navs'];
    if (navs < 0 || navs > 14) problems.push({ trail, error: `navs=${navs}` });
    const key = `${['', 'retain', 'reform', 'reposition', 'repurpose'][s.nav_fate]} / ${['', 'approved', 'conditions', 'deferred'][s.m1_board]}`;
    outcomes.set(key, (outcomes.get(key) || 0) + 1);
    const code = encode(s);
    const back = decode(code);
    if (!back.ok) problems.push({ trail, error: 'code failed: ' + back.error });
    else for (const k of LEDGER) if (Number(back.state[k]) !== Number(s[k])) problems.push({ trail, error: `code mismatch ${k}` });
    endings.set(code, s);
    return;
  }
  const saved = story.state.ToJson();
  for (let i = 0; i < choices.length; i++) {
    story.state.LoadJson(saved);
    const label = story.currentChoices[i].text;
    story.ChooseChoiceIndex(i);
    walk(story, [...trail, label], words);
  }
}

const t0 = Date.now();
const s1 = new Story(load('module1'));
walk(s1, [], 0);
console.log(`Module 1: ${paths} paths walked in ${((Date.now() - t0) / 1000).toFixed(1)}s, ${endings.size} distinct end states`);
console.log('Recommendation and board outcome, by number of paths:');
for (const [k, v] of [...outcomes].sort()) console.log(`  ${k}: ${v}`);
console.log(`Longest path: ${maxWords} words of narration`);
console.log('  ' + maxPath.join(' | '));

// Module 2 opening: with no code, and with every distinct Module 1 ending.
let m2runs = 0;
const run3 = (state) => {
  const st = new Story(load('module2_opening'));
  if (state) { for (const k of LEDGER) st.variablesState[k] = state[k]; st.variablesState.code_loaded = true; }
  let text = '';
  while (st.canContinue) text += st.Continue();
  if (st.currentChoices.length) problems.push({ error: 'Module 2 opening offered choices' });
  if (st.currentErrors && st.currentErrors.length) problems.push({ error: 'Module 2: ' + st.currentErrors });
  m2runs++;
  return text;
};
run3(null);
for (const code of endings.keys()) run3(decode(code).state);
console.log(`Module 2 opening: ${m2runs} runs`);

// Codec: typo detection and random round trips.
const sample = encode({ ...defaults(), done_m1: true, nav_fate: 2, m1_reason: 1 });
let caught = 0, total = 0;
const ALPH = '0123456789ABCDEFGHJKMNPQRSTVWXYZ';
const raw = sample.replace(/^SWC-/, '').replace(/-/g, '');
for (let i = 0; i < raw.length; i++) for (const c of ALPH) {
  if (c === raw[i]) continue;
  total++;
  if (!decode(raw.slice(0, i) + c + raw.slice(i + 1)).ok) caught++;
}
console.log(`Codec: ${caught} of ${total} single-character typos rejected; sample ${sample}`);
if (caught !== total) problems.push({ error: 'typo not caught' });
for (const v of [sample.toLowerCase(), raw, ' ' + sample + ' ', sample.replace(/0/g, 'O')]) if (!decode(v).ok) problems.push({ error: 'lenient input rejected: ' + v });

if (problems.length) {
  console.log(`${problems.length} problems`);
  console.log(JSON.stringify(problems.slice(0, 10), null, 1));
  process.exit(1);
}
console.log('All checks passed.');
