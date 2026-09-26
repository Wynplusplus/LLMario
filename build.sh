#!/bin/sh
# Reassemble the matching disassembly and verify it matches your PRG ROM.
set -e
cd "$(dirname "$0")"

# Use a vendored cc65 if present, otherwise a system install.
if [ -x ./cc65/usr/bin/ca65 ]; then
    PATH="$PWD/cc65/usr/bin:$PATH"
fi
command -v ca65 >/dev/null || { echo "ca65 not found (install cc65)"; exit 1; }

[ -f out/prg.bin ] || {
    echo "out/prg.bin is missing."
    echo "Extract it from your own ROM:  ./extract_rom.sh '/path/to/Super Mario Bros. (World).nes'"
    exit 1
}

echo "== assembling out/smb.asm =="
ca65 -o out/smb.o out/smb.asm
ld65 -C smb.cfg -o out/prg_rebuilt.bin out/smb.o

echo "== comparing PRG ROM =="
cmp out/prg.bin out/prg_rebuilt.bin
echo "PRG: byte-identical ($(wc -c < out/prg.bin) bytes)"

if [ -f out/header.bin ] && [ -f out/chr.bin ]; then
    cat out/header.bin out/prg_rebuilt.bin out/chr.bin > out/smb_rebuilt.nes
    echo "full iNES image: out/smb_rebuilt.nes"
fi
echo "OK"
