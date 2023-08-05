module ALUDecoder #()(
    input  logic [2:0]    func3,
    input  logic [6:0]    func7,
    input  logic          op5,
    input  logic          op4,
    input  logic [2:0]    ALUOp,
    input  logic          branch,
    input  logic          Jlink,
    input  logic          zero,

    output [2:0]    ALUControl_o,
    output  logic   PCSrc_o,
    output  logic   ByteOp
);

always_comb begin
    ByteOp = 0;
    case(ALUOp)
        3'b00: ALUControl_o = 3'b000;
        3'b01: ALUControl_o = 3'b001;
        3'b10: begin
            case(func3)
                3'b001: begin
                    case(op4)
                        1'b1:    ALUControl_o = 3'b101;   //left shift for slli instruction
                        default: ALUControl_o = 3'b000;
                    endcase
                end 
                3'b010: ALUControl_o = 3'b101;
                3'b110: ALUControl_o = 3'b011;
                3'b111: ALUControl_o = 3'b010;
                3'b000: begin
                    case({op5, func7[5]})
                        2'b11: ALUControl_o = 3'b001;
                        default: ALUControl_o = 3'b000;
                    endcase
                end
                default: ALUControl_o = 3'b111; //Idk what to put as of yet
            endcase
        end
        3'b11: begin
               ALUControl_o = 3'b000;
               if(func3==3'b000 | func3==3'b100) ByteOp = 1;
               else ByteOp = 0;
        end
        3'b100: ALUControl_o = 3'b110;
        default: begin
            ALUControl_o = 3'b111; //Idk what to put as of yet
            ByteOp       = 0;
        end
    endcase
end

always_comb begin
    casez({Jlink, func3})
        4'b1???: PCSrc_o = 1;
        4'b0001: begin   // for bne, branch if alu output not zero
            if(branch && !zero) begin 
                PCSrc_o = 1; 
            end                
        end
        default: PCSrc_o = 0;
    endcase
end

endmodule
