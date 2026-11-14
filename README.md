# The Service We Could Become

A short narrative serious game for PHCM9391 Health Organisations, Strategy and Change (UNSW), written in ink and played in the browser with inkjs.

This repository holds a working prototype for the research team: Episode 1 in full, and the opening of Episode 3, which reads the save code from Episode 1. The text is a first draft. Scenes involving the Aboriginal Medical Service are a first draft for review by an Aboriginal colleague.

## Layout

- `episodes/` one ink file per episode
- `shared/ledger.ink` the variables that carry between episodes
- `docs/` the published site (GitHub Pages serves this folder), including the compiled episodes and the save code script
- `tools/build.mjs` compiles every episode and fails on errors
- `tests/walk.mjs` walks every choice path and checks the ledger and save code

## Building

`npm install`, then `npm run build` and `npm test`.

## Licences

The game text is not licensed for reuse. ink and inkjs are by inkle and used under the MIT licence (see `docs/inkjs-LICENSE.txt`).
