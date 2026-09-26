import ghidra.app.script.GhidraScript;
import ghidra.app.cmd.disassemble.DisassembleCommand;
import ghidra.program.model.address.*;
import ghidra.program.model.listing.*;
import java.io.*;

// Seeds recursive disassembly from the 6502 vectors, then exports a text map:
//   I <addrhex> <len> <mnemonic>   instruction start
//   D <addrhex> <len>              data / undefined unit
// The Python generator re-decodes instruction starts with its own table and
// emits .byte for everything else, so reassembly is byte-exact.
public class AnalyzeDump extends GhidraScript {
    private Address a(long v) {
        return currentProgram.getAddressFactory().getDefaultAddressSpace().getAddress(v);
    }
    private void seed(long v) {
        DisassembleCommand cmd = new DisassembleCommand(a(v), null, true);
        cmd.applyTo(currentProgram, monitor);
    }
    @Override
    public void run() throws Exception {
        // Start from a clean slate so pre-created data units cannot block
        // recursive disassembly into call/branch targets.
        clearListing(a(0x8000), a(0xFFFF));

        // RESET, NMI and IRQ vectors from the SMB ROM.
        seed(0x8000);
        seed(0x8082);
        seed(0xFFF0);

        // The 6502 interrupt vector table must stay data; a routine ending near
        // it can otherwise be disassembled through the vectors.
        try {
            clearListing(a(0xFFFA), a(0xFFFF));
        } catch (Exception e) {
            println("clearListing: " + e);
        }

        String out = getScriptArgs()[0];
        Listing listing = currentProgram.getListing();
        Address start = a(0x8000), end = a(0xFFFF);
        int insns = 0, units = 0;
        try (PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter(out)))) {
            Address cur = start;
            while (true) {
                long off = cur.getOffset();
                Instruction in = listing.getInstructionAt(cur);
                long len;
                if (off < 0xFFFAL && in != null && in.getAddress().equals(cur)
                        && (off + in.getLength()) <= 0xFFFFL) {
                    len = in.getLength();
                    pw.println("I " + cur + " " + len + " " + in.toString());
                    insns++;
                } else {
                    Data d = listing.getDataAt(cur);
                    len = 1;
                    if (off < 0xFFFAL && d != null && d.getAddress().equals(cur)
                            && (off + d.getLength()) <= 0xFFFFL) {
                        len = d.getLength();
                    }
                    pw.println("D " + cur + " " + len);
                    units++;
                }
                if (off + len > 0xFFFFL) {
                    break;
                }
                cur = cur.add(len);
            }
        }
        println("AnalyzeDump: instructions=" + insns + " units=" + units);
    }
}
