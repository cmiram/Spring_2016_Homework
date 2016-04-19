EXE = main

SOURCES = \
		PcRegister.v \
		RegisterFile.v \
		Memory.v \
		Register.v \
		Alu.v \
		SignExtend.v \
		ShiftLeft.v \
		Mux.v \
		ControlUnit.v \
		Datapath.v \
        ShiftLeft2.v \
		Main.v

$(EXE): $(SOURCES)
	iverilog -o $(EXE) $(SOURCES)

clean:
	rm -f $(EXE)



