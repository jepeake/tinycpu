module ALU #(
    parameter DATA_WIDTH = 32
)(
    input  logic   [DATA_WIDTH-1:0] ALUop1,
    input  logic   [DATA_WIDTH-1:0] ALUop2,
    input  logic   [2:0]            ALUctrl,
    output logic   [DATA_WIDTH-1:0] ALUout,
    output logic                    zero_o
);

    typedef enum bit[2:0] {ADD, SUBTRACT, AND, OR, SLT, LSHIFT, PASSOP2} func;

    always_comb begin
        case(ALUctrl)
            ADD: ALUout = ALUop1 + ALUop2;
            SUBTRACT: ALUout = ALUop1 - ALUop2;
            AND: ALUout = ALUop1 & ALUop2;
            OR: ALUout = ALUop1 | ALUop2;
            SLT: ALUout = (ALUop1 < ALUop2) ? 1 : 0;
            LSHIFT: ALUout = ALUop1 << ALUop2;
            PASSOP2: ALUout = ALUop2;
            default: ALUout = ALUop1 + ALUop2;
        endcase
    end;


    always_comb begin
        if(ALUout == 0) begin
            zero_o = 1;
        end
        else begin zero_o = 0; end
    end

endmodule
