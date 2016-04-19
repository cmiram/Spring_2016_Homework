Run the testbench file cpu_tb.v

When simulating in ModelSim:
    clk: Set clock signal to period of 100000 with a duty of 50.
    clr: Force clr to 1 initially and cancel after 100.
    
    inst: This output shows the current instruction executing
    read_data2_out: Shows the output of read_data2 from the register file and is used to verify the 
        correct output calculations at the end of the MinMax.hexdump execution.
        
Run for 16 us because when the opcode for hlt (0xfc) appears the cpu immediatly runs $finish to 
    manually cancel simulation.