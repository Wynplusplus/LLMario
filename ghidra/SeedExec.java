import ghidra.app.script.GhidraScript;
import ghidra.program.model.mem.MemoryBlock;
import ghidra.program.model.address.Address;
import ghidra.program.model.address.AddressSpace;

// Mark the raw PRG block executable and register the 6502 vectors as entry
// points so Ghidra's analyzers can propagate code discovery.
public class SeedExec extends GhidraScript {
    @Override
    public void run() throws Exception {
        for (MemoryBlock b : currentProgram.getMemory().getBlocks()) {
            b.setRead(true);
            b.setWrite(true);
            b.setExecute(true);
        }
        AddressSpace sp = currentProgram.getAddressFactory().getDefaultAddressSpace();
        for (long v : new long[] { 0x8000L, 0x8082L, 0xFFF0L }) {
            Address a = sp.getAddress(v);
            currentProgram.getSymbolTable().addExternalEntryPoint(a);
        }
        println("SeedExec: block executable, entry points added");
    }
}
