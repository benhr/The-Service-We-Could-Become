// Compiles every episode to JSON for the web page. Fails on any ink error.
// INCLUDE lines are resolved here, relative to the episode file.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { Compiler, CompilerOptions } from 'inkjs/full';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
export const episodes = ['ep1', 'ep3_preview'];

export function compile(ep) {
  const file = path.join(root, 'episodes', ep + '.ink');
  // Included files go at the end so their functions don't swallow the episode's top-level content.
  const includes = [];
  const body = fs.readFileSync(file, 'utf8').replace(/^INCLUDE\s+(.+)$/gm, (_, inc) => {
    includes.push(fs.readFileSync(path.resolve(path.dirname(file), inc.trim()), 'utf8'));
    return '';
  });
  const src = body + '\n' + includes.join('\n');
  const messages = [];
  const opts = new CompilerOptions(null, [], false, (msg, type) => messages.push({ msg, type }));
  let story = null;
  try { story = new Compiler(src, opts).Compile(); } catch (e) { messages.push({ msg: String(e.message || e).slice(0, 300), type: 2 }); }
  return { story, messages };
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  let failed = false;
  fs.mkdirSync(path.join(root, 'docs'), { recursive: true });
  for (const ep of episodes) {
    const { story, messages } = compile(ep);
    for (const m of messages) console.log(`${ep}: ${m.msg}`);
    if (!story || messages.some(m => m.type === 2)) { failed = true; continue; }
    fs.writeFileSync(path.join(root, 'docs', ep + '.json'), story.ToJson());
    console.log(`${ep}: compiled`);
  }
  if (failed) process.exit(1);
}
