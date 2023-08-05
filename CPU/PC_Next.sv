module PC_Next #(
    parameter WIDTH = 32
)(
    // interface signals
    input logic [WIDTH-1:0]     PC_i,         //PC cycle
    input logic [WIDTH-1:0]     ImmOp_i,      //Immediate Operand 
    input logic [WIDTH-1:0]     PC_Jalr_i,    //PC from register for JALR
    input logic                 PCsrc_i,      //PC src - Control signal for JAL and BRANCH
    input logic                 PCsrcReg_i,   //Control signal for JALR
    output logic [WIDTH-1:0]    PC_Next_o,    //next PC output
    output logic [WIDTH-1:0]    PC_Plus4_o    //PC+4 output
);

    logic [WIDTH-1:0]   JAL_branch_PC;
    logic [WIDTH-1:0]   inc_PC;

    assign JAL_branch_PC = PC_i + ImmOp_i;
    assign inc_PC = PC_i + 4;

    assign PC_Next_o  = PCsrcReg_i ? PC_Jalr_i : (PCsrc_i ? JAL_branch_PC : inc_PC);
    assign PC_Plus4_o = inc_PC;
    
endmodule
