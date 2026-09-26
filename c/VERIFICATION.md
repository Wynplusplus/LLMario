# Verification of the C decompilation

Each round is an independent OpenCode session running `opencode/deepseek-v4.1-flash`.
Prompts and full transcripts are kept alongside this file.

| Round | Prompt | Result | Outcome |
| --- | --- | --- | --- |
| 1 | `VERIFY_PROMPT.txt` / `VERIFY_ITER1.txt` | **FAIL** | Found 5 reachable instruction entry points missing from the C (`$8223`, `$C902`, `$C905`, `$BFB7`, `$DC21` -- the `BIT abs` operand-as-entry idiom), and showed the diff test could not detect translation gaps. Gave exact fix instructions. |
| 2 | `VERIFY_PROMPT2.txt` / `VERIFY_ITER2.txt` | (incomplete) | Verified the fixes and the semantics, then found a false positive: gap detection flagged RAM addresses below `$8000`. The run ended on an upstream API error before a verdict. |
| 3 | `VERIFY_PROMPT3.txt` / `VERIFY_ITER3.txt`, `VERIFY_ITER4.txt` | **PASS** | All checks pass: builds, diff test `mismatches=0 gaps=0`, gap detector non-vacuous, an independent traversal found 0 reachable-but-untranslated instructions, and 44 hand-computed 6502 semantic checks passed. No changes required. |

## Fixes applied in response to round 1

* `gen_c.py` expands the code map with all static control-flow targets
  (JSR/JMP/branch operands plus fall-through/return sites) to a fixpoint,
  decoding overlapping instruction streams directly from the ROM (65 added
  entry points).
* `difftest.c` gained Phase 0 (vector traces), Phase 1b (coverage assertion)
  and gap detection; a gap is now a failure rather than a silent end of trace.

## Fix applied in response to round 2

* Gap detection only treats `$8000-$FFFF` addresses holding a valid opcode as
  required translations; a target below `$8000` is RAM, not a gap.

## Independent evidence from the passing round

```
translated=10320  trials=10910 steps=78629 mismatches=0 gaps=0
out/smb_prg_x64.o:   ELF 64-bit LSB relocatable, x86-64 ...
out/smb_prg_arm64.o: ELF 64-bit LSB relocatable, ARM aarch64 ...
```

* Gap detector proven non-vacuous by deleting one `optab[...]` entry: the test
  then reports `GAP: translated address $8223 has no function` and 3 gaps.
* The verifier's own recursive traversal (dereferencing the vectors) reported
  `reached-but-untranslated (valid opcode): 0` and
  `closure violations ...: 0`.
* 44 hand-computed 6502 results (ADC/SBC carry+overflow, ROL/ROR, ASL/LSR, BIT,
  CMP, JSR/RTS, BRK) matched the generated code.
