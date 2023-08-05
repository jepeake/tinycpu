#include <iostream>
#include <iomanip>
#include "VInstrMem.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

Verilated::commandArgs(argc, argv);
// init top verilog instance
VInstrMem* top = new VInstrMem;
//init trace dump
Verilated::traceEverOn(true);
VerilatedVcdC* tfp = new VerilatedVcdC;
top->trace (tfp, 99);
tfp->open ("InstrMem.vcd");

//initialize simulation inputs
top->PC = 0x0;

//run simulation for many clock cycles 
for (i=0; i<10; i++){
    
    //dump variables into VCD file
    top->eval ();

    int num = int(top->instr);
    std::cout << std::setw(8) << std::setfill('0') << std::hex << num << std::endl;

    top->PC = (int(top->PC) + 4);
    

    if  (Verilated::gotFinish())
        exit(0);                
}
        tfp->close();
}
