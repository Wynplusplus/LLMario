#!/bin/sh
# Split a user-supplied iNES ROM into the parts the tools expect.
#
#   ./extract_rom.sh "/path/to/Super Mario Bros. (World).nes"
#
# The repository ships no ROM data; this reads your own copy.
set -e
cd "$(dirname "$0")"

ROM="${1:?usage: extract_rom.sh '/path/to/Super Mario Bros. (World).nes'}"
[ -f "$ROM" ] || { echo "no such file: $ROM" >&2; exit 1; }

mkdir -p out
python3 - "$ROM" <<'PY'
import sys, hashlib
rom = open(sys.argv[1], "rb").read()
if len(rom) < 16 or rom[:3] != b"NES":
    sys.exit("not an iNES ROM")
prg = rom[16:16 + 32768]
if len(prg) != 32768:
    sys.exit("unexpected ROM size (need 2x16k PRG + 8k CHR)")
open("out/header.bin", "wb").write(rom[:16])
open("out/prg.bin", "wb").write(prg)
open("out/chr.bin", "wb").write(rom[16 + 32768:])
h = hashlib.sha256(prg).hexdigest()
open("out/prg.sha256", "w").write(h + "\n")
print("PRG sha256:", h)
known = "5374abb64cfb9b5d961856c60166cedc55859164cf2b8867730e144fa2bdd594"
if h == known:
    print("OK: matches the Super Mario Bros. (World) PRG this decomp was made from")
else:
    print("WARNING: PRG hash differs from the one this decomp was made from")
    print("         expected", known)
PY
echo "wrote out/header.bin out/prg.bin out/chr.bin"
