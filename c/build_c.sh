#!/bin/sh
# Build the decompiled C for x86-64 and aarch64, and run the differential test.
set -e
cd "$(dirname "$0")"

ZIG="${ZIG:-/tmp/opencode/zig/zig}"
command -v gcc >/dev/null || { echo "gcc not found"; exit 1; }
[ -x "$ZIG" ] || { echo "zig not found (set ZIG=/path/to/zig)"; exit 1; }

echo "== generating out/smb_prg.c =="
python3 gen_c.py

echo "== x86_64 object =="
gcc -O1 -std=c11 -I. -c out/smb_prg.c -o out/smb_prg_x64.o
ar rcs out/libsmb_prg_x64.a out/smb_prg_x64.o

echo "== aarch64 object =="
"$ZIG" cc -target aarch64-linux-gnu -O1 -std=c11 -I. -ffreestanding -nostdlib \
    -c out/smb_prg.c -o out/smb_prg_arm64.o
ar rcs out/libsmb_prg_arm64.a out/smb_prg_arm64.o

echo "== differential test (decompiled C vs independent interpreter) =="
PRG="${SMB_PRG:-../out/prg.bin}"
if [ -f "$PRG" ]; then
    gcc -O2 -std=c11 -I. -o out/difftest difftest.c ref6502.c out/smb_prg.c
    ./out/difftest "$PRG"
else
    echo "skipped: no PRG image at $PRG"
    echo "extract it from your own ROM first:  ../extract_rom.sh '/path/to/Super Mario Bros. (World).nes'"
fi

echo "== PPU command trace (decompiled CPU driving the PPU model) =="
PRG="${SMB_PRG:-../out/prg.bin}"
if [ -f "$PRG" ]; then
    gcc -O2 -std=c11 -I. -o out/pputrace pputrace.c ppu.c out/smb_prg.c
    ./out/pputrace "$PRG" | head -40
else
    echo "skipped: no PRG image at $PRG"
fi

echo "== architectures =="
file out/smb_prg_x64.o out/smb_prg_arm64.o
echo "OK"
