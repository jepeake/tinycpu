/* verilator lint_off UNOPTFLAT */

module cpu #(
    parameter   DATA_WIDTH = 32            // Parameters
)(
    input logic                     clk,   // Input/Output Logic
    input logic                     rst,
    output logic [DATA_WIDTH-1:0]   a0                  
);
    logic [DATA_WIDTH-1:0] ALUop1;         // Interconnecting Wires For ALU
    logic [DATA_WIDTH-1:0] ALUout;
    logic [2:0]            ALUctrl;
    logic                  ALUsrc;
    logic                  zero;

    logic [DATA_WIDTH-1:0] regOp2;         // Interconnecting Wires For RegFile
    logic                  RegWrite;
    logic                  ResultSrc;
    logic                  StorePC;

    logic [DATA_WIDTH-1:0] ImmOp;          // Interconnecting Wires For Sign Extend
    logic [2:0]            ImmSrc;

    logic [DATA_WIDTH-1:0] instr;          // Interconnecting Wires For PC
    logic [DATA_WIDTH-1:0] pc;
    logic [DATA_WIDTH-1:0] next_pc;
    logic [DATA_WIDTH-1:0] PC_Plus4;
    logic                  PCsrc;
    logic                  PCsrcReg;
    
    logic [DATA_WIDTH-1:0] ReadData;       // Interconnecting Wires For Data Memory
    logic                  MemWrite;
    logic                  ByteOp;

    RegFile RegFile (          
        .clk (clk),
        .ad1 (instr[19:15]),
        .ad2 (instr[24:20]),
        .ad3 (instr[11:7]),
        .we3 (RegWrite),
        .wd3 (StorePC ? PC_Plus4 : (ResultSrc ? ReadData : ALUout)),
        .rd1 (ALUop1),
        .rd2 (regOp2),
        .a0 (a0)
    );

    ALU ALU (
        .ALUop1 (ALUop1),
        .ALUop2 (ALUsrc ? ImmOp : regOp2),
        .ALUout (ALUout),
        .zero_o (zero),
        .ALUctrl (ALUctrl)
    );

    SignExtend SignExtend (
        .ImmOp (ImmOp),
        .ImmSrc (ImmSrc),
        .instr (instr[31:7])
    );

    InstrMem InstrMem (
        .instr  (instr),
        .PC     (pc)
    );

    PC_Register PCReg (
        .PC_o         (pc),
        .PC_Next_i    (next_pc),
        .clk          (clk),
        .rst          (rst)
    );
    
    PC_Next PCMux (
        .PC_i (pc),
        .ImmOp_i (ImmOp),
        .PC_Jalr_i (ALUout),
        .PCsrc_i (PCsrc),
        .PCsrcReg_i (PCsrcReg),
        .PC_Next_o (next_pc),
        .PC_Plus4_o (PC_Plus4)
    );

    ControlUnit ControlUnit (
        .instr_i (instr),
        .zero_i   (zero),
        .PCSrc_o (PCsrc),
        .PCSrcReg_o (PCsrcReg),
        .StorePC_o  (StorePC),
        .ResultSrc_o (ResultSrc),
        .MemWrite_o (MemWrite),
        .ALUControl_o (ALUctrl),
        .ALUSrc_o (ALUsrc),
        .ImmSrc_o (ImmSrc),
        .ByteOp   (ByteOp),
        .RegWrite_o (RegWrite)
    );
    
    DataMem DataMem (
        .clk (clk),
        .we (MemWrite),
        .ByteOp  (ByteOp),
        .Address (ALUout),
        .WriteData (regOp2),
        .ReadData (ReadData)
    );
    

endmodule
