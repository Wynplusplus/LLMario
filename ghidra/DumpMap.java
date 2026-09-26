import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.*;
import ghidra.program.model.listing.*;
import ghidra.program.model.mem.Memory;
import ghidra.program.model.mem.MemoryBlock;
import java.io.*;

// Exports the analysis result as a simple text map:
//   I <addrhex> <len> <mnemonic>   - instruction starts
//   D <addrhex> <len>              - data/undefined units
// Python re-disassembles the instruction starts with its own table and emits
// .byte for everything not covered by an instruction.
public class DumpMap extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        File out = new File(args[0]);
        Listing listing = currentProgram.getListing();
        AddressSpace sp = currentProgram.getAddressFactory().getDefaultAddressSpace();
        Address start = sp.getAddress(0x8000L);
        Address end = sp.getAddress(0xFFFFL);

        int insns = 0, units = 0;
        try (PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter(out)))) {
            Address cur = start;
            while (cur.compareTo(end) <= 0) {
                Instruction insn = listing.getInstructionAt(cur);
                if (insn != null && insn.getAddress().equals(cur)) {
                    pw.println("I " + cur + " " + insn.getLength() + " " + insn.toString());
                    insns++;
                    cur = cur.add(insn.getLength());
                } else {
                    Data d = listing.getDataAt(cur);
                    int len = 1;
                    if (d != null && d.getAddress().equals(cur)) {
                        len = d.getLength();
                    }
                    pw.println("D " + cur + " " + len);
                    units++;
                    cur = cur.add(len);
                }
            }
        }
        println("DumpMap: instructions=" + insns + " data/undef units=" + units);
    }
}
