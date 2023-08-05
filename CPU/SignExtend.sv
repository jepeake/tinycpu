module SignExtend #(
    parameter   INSTR_WIDTH = 32
)(
    input logic                [31:7]      instr,
    input logic                 [2:0]      ImmSrc,
    output logic    [INSTR_WIDTH-1:0]      ImmOp
);

    typedef enum bit[2:0]   {Imm, Store, Branch, Jump, UppImm}   Instr_type;

always_comb begin
    case(ImmSrc)
        Imm:        ImmOp = {{20{instr[31]}}, instr[31:20]};
        Store:      ImmOp = {{20{instr[31]}}, instr[31:25], instr[11:7]};
        Branch:     ImmOp = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
        Jump:       ImmOp = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
        UppImm:     ImmOp = {instr[31:12], 12'b0};
        default:    ImmOp = {{20{instr[31]}}, instr[31:20]};
    endcase
end; 
           
endmodule
