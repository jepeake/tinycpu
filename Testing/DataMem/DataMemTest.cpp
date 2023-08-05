#include <iostream>
#include <iomanip>
#include "VDataMem.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

Verilated::commandArgs(argc, argv);
// init top verilog instance
VDataMem* top = new VDataMem;
//init trace dump
Verilated::traceEverOn(true);
VerilatedVcdC* tfp = new VerilatedVcdC;
top->trace (tfp, 99);
tfp->open ("DataMem.vcd");

//initialize simulation inputs
top->we = 1;
top->clk = 1;
top->Address = 0;
top->WriteData = 0x1;

//run simulation for many clock cycles 
for (i=0; i<10; i++){
    
    for (clk=0; clk<2; clk++) {
            tfp->dump (2*i+clk);
            top->clk = !top->clk;
            top->eval ();
        }

    int num = int(top->ReadData);
    std::cout << std::setw(8) << std::setfill('0') << std::hex << num << std::endl;

    top->WriteData = 0x2;
    top->Address = 0x4;
    
    if (Verilated::gotFinish()){     
            tfp->close();
            exit(0);
        }               
}

}
