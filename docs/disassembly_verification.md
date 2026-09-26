# Independent verification (OpenCode session, model `opencode/deepseek-v4.1-flash`)

A separate OpenCode session was asked to independently verify the instruction
match, without trusting the README. Its full transcript is in
`VERIFY_RESULT.txt`; its own from-scratch verifier is `verify_independent.py`.

Verdict: **MATCH** — no discrepancies, no fix required.

Evidence it produced:

* sha256 `out/prg.bin` = `5374abb6…d594` and `out/original.nes` =
  `0b3d9e1f…6dea`, both matching the expected values.
* `./build.sh` → `cmp` byte-identical for the 32768-byte PRG and the full
  40976-byte ROM.
* A separate re-encoder with its **own** 6502 opcode table (not imported from
  `gen.py`) parsed all 10255 instructions and re-encoded each one:
  0 errors; every `; $ADDR: bytes` comment equals the ROM; forced sizes and
  relative branches round-trip.
* Coverage walk: 11042 records (10255 instructions + 787 `.byte` lines)
  strictly cover `$8000-$FFFF`, ending exactly at `$10000`, with no gaps and
  no overlaps.
* `da65` cross-check: 7940 exact mnemonics; every one of the 688 disagreements
  was shown to be a `da65` desync on level data (it linearly decoded `20 40 80`
  in data as a fake `JSR $8040`), not an `smb.asm` error.
