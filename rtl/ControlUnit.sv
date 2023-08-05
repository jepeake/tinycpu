module ControlUnit #(
    parameter INSTR_WIDTH = 32
)(
	input   [INSTR_WIDTH-1:0]   instr_i,
    input   logic               zero_i,

	output  logic               PCSrc_o,
    output  logic               PCSrcReg_o,
    output  logic               StorePC_o,
    output  logic               ResultSrc_o,
    output  logic               MemWrite_o,
    output  logic               ByteOp,
    output  [2:0]               ALUControl_o,
    output  logic               ALUSrc_o,
    output  [2:0]               ImmSrc_o,
    output  logic               RegWrite_o
);

    logic   [6:0]               opcode;
    logic   [2:0]               func3;
    logic   [6:0]               func7;
    logic   [2:0]               ALUOp;
    logic                       branch;
    logic                       Jlink;

    assign opcode = instr_i[6:0];
    assign func3 = instr_i[14:12];
    assign func7 = instr_i[31:25];


    ALUDecoder ALUDecoder (
        .func3          (func3),
        .func7          (func7),
        .op5            (opcode[5]),
        .op4            (opcode[4]),
        .ALUOp          (ALUOp),
        .ALUControl_o   (ALUControl_o),
        .branch         (branch),
        .zero           (zero_i),
        .Jlink          (Jlink),
        .PCSrc_o        (PCSrc_o),
        .ByteOp         (ByteOp)
    );

    ControlUnitDecoder ControlUnitDecoder (
        .opcode_i       (opcode),
        .Branch_o       (branch),
        .Jlink_o        (Jlink),
        .ResultSrc_o    (ResultSrc_o),
        .MemWrite_o     (MemWrite_o),
        .ALUSrc_o       (ALUSrc_o),
        .ImmSrc_o       (ImmSrc_o),
        .RegWrite_o     (RegWrite_o),
        .ALUOp_o        (ALUOp),
        .PCSrcReg_o     (PCSrcReg_o),
        .StorePC_o      (StorePC_o)
    );
    

endmodule
