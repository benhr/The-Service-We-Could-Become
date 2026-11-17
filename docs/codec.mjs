// Save code: 80 bits as 16 Crockford base32 characters, shown as EP-XXXX-XXXX-XXXX-XXXX.
// Codes made before 17 November 2026 carry the old prefix SWC; both prefixes are accepted.
// Layout: format version (3) | modules completed (10, five used) | 7 tracks x 3 | flags (40) | CRC-6 (6).
// The code carries game decisions only. Nothing identifies a person and nothing is sent anywhere.

export const FORMAT_VERSION = 1;
const ALPHABET = '0123456789ABCDEFGHJKMNPQRSTVWXYZ';

export const DONE = ['done_m1', 'done_r2', 'done_m2', 'done_r4', 'done_m3',
  'done_r6', 'done_m4', 'done_r8', 'done_m5', 'done_r10'];

export const TRACKS = [
  { name: 'trust_hospital', def: 4 }, { name: 'trust_primary', def: 4 },
  { name: 'partner_lhd', def: 4 }, { name: 'partner_phn', def: 4 },
  { name: 'partner_ams', def: 3 }, { name: 'community', def: 4 },
  { name: 'confidence', def: 4 },
];

// Flag registry, in bit order. 39 bits used of 40.
// m1_board was added at the end (November 2026) so earlier codes still decode.
// Flags are grouped by module: m1 (Module 1), then reserved, Module 2, reserved, and so on.
export const FLAGS = [
  ['nav_fate', 3], ['m1_ams_contacted', 1], ['m1_reason', 2],
  ['reserved_a', 2],
  ['brief_basis', 2], ['ams_terms', 2], ['brief_names_unknowns', 1], ['m2_consumers_consulted', 1],
  ['reserved_b', 2],
  ['intake_path', 2], ['gp_council_involved', 1], ['allied_health_included', 1], ['named_the_losses', 1], ['intake_launched_early', 1],
  ['reserved_c', 2],
  ['plan_author', 2], ['plan_stops_something', 1], ['plan_ams_consulted', 1], ['plan_shared_before_board', 1],
  ['reserved_d', 2],
  ['response_stance', 2], ['outside_mandate_voices', 2], ['coalition_built', 1], ['staff_told_first', 1],
  ['m1_board', 2],
];
const FLAG_BITS = 40;

function crc6(bits) {
  // CRC-6 with polynomial x^6 + x + 1, over an array of 0/1.
  let reg = 0;
  for (const b of bits) {
    const top = ((reg >> 5) & 1) ^ b;
    reg = (reg << 1) & 0x3f;
    if (top) reg ^= 0x03;
  }
  return reg;
}

function pushBits(arr, value, n) {
  for (let i = n - 1; i >= 0; i--) arr.push((value >> i) & 1);
}

function readBits(arr, pos, n) {
  let v = 0;
  for (let i = 0; i < n; i++) v = (v << 1) | arr[pos + i];
  return v;
}

export function defaults() {
  const s = {};
  for (const d of DONE) s[d] = false;
  for (const t of TRACKS) s[t.name] = t.def;
  for (const [name] of FLAGS) s[name] = 0;
  return s;
}

export function encode(state) {
  const bits = [];
  pushBits(bits, FORMAT_VERSION, 3);
  for (const d of DONE) bits.push(state[d] ? 1 : 0);
  for (const t of TRACKS) pushBits(bits, Math.max(0, Math.min(7, Number(state[t.name]) | 0)), 3);
  let used = 0;
  for (const [name, n] of FLAGS) {
    const max = (1 << n) - 1;
    pushBits(bits, Math.max(0, Math.min(max, Number(state[name]) | 0)), n);
    used += n;
  }
  pushBits(bits, 0, FLAG_BITS - used);
  pushBits(bits, crc6(bits), 6);
  let chars = '';
  for (let i = 0; i < 80; i += 5) chars += ALPHABET[readBits(bits, i, 5)];
  return 'EP-' + chars.match(/.{4}/g).join('-');
}

// Returns { ok: true, state } or { ok: false, error }.
export function decode(input) {
  let s = String(input || '').toUpperCase().replace(/[\s-]/g, '');
  if (s.length === 19 && s.startsWith('SWC')) s = s.slice(3);
  else if (s.length === 18 && s.startsWith('EP')) s = s.slice(2);
  s = s.replace(/O/g, '0').replace(/[IL]/g, '1');
  if (s.length !== 16) return { ok: false, error: 'That code is the wrong length. A code has 16 characters after EP.' };
  const bits = [];
  for (const c of s) {
    const v = ALPHABET.indexOf(c);
    if (v < 0) return { ok: false, error: `That code contains a character that codes never use (${c}).` };
    pushBits(bits, v, 5);
  }
  const body = bits.slice(0, 74);
  if (crc6(body) !== readBits(bits, 74, 6)) return { ok: false, error: 'That code does not pass the check. There may be a typing error.' };
  if (readBits(bits, 0, 3) !== FORMAT_VERSION) return { ok: false, error: 'That code comes from a different version of the game.' };
  const state = {};
  let pos = 3;
  for (const d of DONE) state[d] = bits[pos++] === 1;
  for (const t of TRACKS) { state[t.name] = readBits(bits, pos, 3); pos += 3; }
  for (const [name, n] of FLAGS) { state[name] = readBits(bits, pos, n); pos += n; }
  return { ok: true, state };
}
