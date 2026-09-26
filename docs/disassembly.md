# Super Mario Bros. (World) — matching disassembly

A disassembly of the NES *Super Mario Bros. (World)* PRG ROM that **reassembles
byte-for-byte to the original**, produced with Ghidra (headless, 6502) plus
`ca65`/`ld65`.

## Result

| Metric | Value |
| --- | --- |
| Original ROM | `Super Mario Bros. (World).nes` (40976 B) |
| PRG ROM | 32768 B at CPU `$8000-$FFFF` |
| Instructions decoded | 10255 |
| Code bytes | 21826 (66.6% of PRG) |
| Data bytes (`.byte`) | 10942 |
| Branch labels | 1062 |

* `out/prg.bin` (original) and `out/prg_rebuilt.bin` (assembled) — identical,
  `sha256 5374abb64cfb9b5d961856c60166cedc55859164cf2b8867730e144fa2bdd594`.
* `out/original.nes` and `out/smb_rebuilt.nes` — identical,
  `sha256 0b3d9e1f01ed1668205bab34d6c82b0e281456e137352e4f36a9b2cfa3b66dea`.

Verify with:

```sh
./build.sh
```

## Files

| File | Purpose |
| --- | --- |
| `out/smb.asm` | Generated ca65 source (10255 instructions + data) |
| `smb.cfg` | `ld65` config: 32 KiB segment loaded at `$8000` |
| `gen.py` | Disassembler/generator (Ghidra map → ca65 source) |
| `build.sh` | Assemble + `cmp` against the original |
| `ghidra/AnalyzeDump.java` | Headless Ghidra script: recursive disassembly + map export |
| `ghidra/SeedExec.java` | Marks the raw block executable and adds entry points |
| `out/ghidra_map.txt` | Ghidra's instruction/data map |
| `out/prg.bin`, `out/chr.bin`, `out/header.bin` | ROM split into parts |

## Method

1. **Split the iNES ROM** into 16-byte header, 32 KiB PRG and 8 KiB CHR.
   Vectors: RESET `$8000`, NMI `$8082`, IRQ `$FFF0`.
2. **Ghidra headless** (`flatpak run … analyzeHeadless`) imports the PRG as a
   raw binary (`6502:LE:16:default`, base `$8000`), marks it executable, adds
   the vectors as entry points, and recursively disassembles from them. A
   post-script (`AnalyzeDump.java`) exports a per-address instruction/data map.
3. **`gen.py`** runs an independent recursive-traversal disassembler seeded
   from the vectors *and* Ghidra's instruction starts. It resolves the game's
   in-line jump table at `JSR $8E04` (the classic `JumpEngine`: `PLA`/`STA`
   pointer dispatch) so the handlers those tables point at are decoded too.
   Targets take priority over straight-line fall-through and overlapping
   decodes are rejected, so every byte is covered exactly once.
4. **Emit ca65 source.** Instructions use forced sizes (`z:`, `a:`) so the
   assembler reproduces the exact addressing modes; relative branches use
   labels; everything not proven to be code becomes `.byte`. Each line carries
   a `; $ADDR: bytes` comment.
5. **Assemble and compare** with `ca65`/`ld65`; `cmp` confirms byte-exactness.

## Reproducing from scratch

```sh
# 1. Ghidra map (Ghidra 12.x via Flatpak)
flatpak run --command=/app/lib/ghidra/support/analyzeHeadless \
  org.ghidra_sre.Ghidra ghidra proj \
  -import out/prg.bin -processor 6502:LE:16:default \
  -loader BinaryLoader -loader-baseAddr 0x8000 -overwrite \
  -scriptPath ghidra -preScript SeedExec.java \
  -postScript AnalyzeDump.java out/ghidra_map.txt

# 2. Generate the assembly
python3 gen.py

# 3. Assemble and verify
./build.sh
```

`cc65` (`ca65`/`ld65`/`da65`) is vendored under `cc65/` (extracted from the
Fedora `cc65` RPM); a system install also works.

## Scope and limitations

* The match is **byte-exact**: the generated assembly reproduces the ROM
  exactly, and the `; $ADDR: bytes` comments let each instruction be checked
  against the original opcode bytes.
* Code discovery is static: routines reachable only through runtime-computed
  pointers (zero-page indirect dispatch other than `$8E04`) may remain as
  `.byte` data. Such bytes still reassemble correctly; they are simply not
  labelled as code yet.
* This is a matching disassembly, not a C decompilation, and contains no game
  content beyond the structure of the ROM you supplied.
