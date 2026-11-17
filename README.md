# Establishment Phase: Leading a new kind of health organisation

A short narrative serious game for PHCM9391 Health Organisations, Strategy and Change (UNSW), written in ink and played in the browser with inkjs.

The game has five modules, one for each two-week module of the course (Module 1 covers Weeks 1 and 2, Module 2 covers Weeks 3 and 4, and so on). This repository holds a working prototype for the research team: Module 1 in full, and the opening of Module 2, which reads the save code from Module 1. The text is a first draft. Scenes involving the Aboriginal Medical Service are a first draft for review by an Aboriginal colleague.

## Layout

- `modules/` one ink file per module
- `shared/ledger.ink` the variables that carry between modules
- `docs/` the published site (GitHub Pages serves this folder), including the compiled modules and the save code script
- `tools/build.mjs` compiles every module and fails on errors
- `tests/walk.mjs` walks every choice path and checks the ledger and save code

## Building

`npm install`, then `npm run build` and `npm test`.

## Licences

The game text is not licensed for reuse. ink and inkjs are by inkle and used under the MIT licence (see `docs/inkjs-LICENSE.txt`).
