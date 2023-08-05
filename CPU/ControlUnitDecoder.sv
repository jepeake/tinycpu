module ControlUnitDecoder #()(
    input [6:0]                 opcode_i,

	output  logic               Branch_o,
    output  logic               Jlink_o,
    output  logic               ResultSrc_o,
    output  logic               MemWrite_o,
    output  logic               ALUSrc_o,
    output  [2:0]               ImmSrc_o,
    output  logic               RegWrite_o,
    output  [2:0]               ALUOp_o,
    output  logic               PCSrcReg_o,
    output  logic               StorePC_o
);

typedef enum bit[6:0]   {
        RType        =   7'b0110011,
        Load         =   7'b0000011,
        IType        =   7'b0010011,
        SType        =   7'b0100011,
        BType        =   7'b1100011,
        AddUpp       =   7'b0010111,
        LoadUpp      =   7'b0110111,
        JumpLink     =   7'b1101111,
        JumpLinkReg  =   7'b1100111
        
    }                           Opcode;

    always_comb begin
        case (opcode_i)
            RType: begin
                Branch_o    = 1'b0;
                ResultSrc_o = 1'b0;
                MemWrite_o  = 1'b0;
                ALUSrc_o    = 1'b0;
                ALUOp_o     = 3'b10;
                ImmSrc_o    = 3'b0;
                RegWrite_o  = 1'b1;
                Jlink_o     = 1'b0;
                PCSrcReg_o  = 1'b0;
                StorePC_o   = 1'b0;
            end
            Load: begin
                Branch_o    = 1'b0;
                ResultSrc_o = 1'b1;
                MemWrite_o  = 1'b0;
                ALUSrc_o    = 1'b1;
                ALUOp_o     = 3'b11;
                ImmSrc_o    = 3'b0;
                RegWrite_o  = 1'b1;
                Jlink_o     = 1'b0;
                PCSrcReg_o  = 1'b0;
                StorePC_o   = 1'b0;
            end
            IType: begin
                Branch_o    = 1'b0;
                ResultSrc_o = 1'b0;
                MemWrite_o  = 1'b0;
                ALUSrc_o    = 1'b1;
                ALUOp_o     = 3'b10;
                ImmSrc_o    = 3'b0;
                RegWrite_o  = 1'b1;
                Jlink_o     = 1'b0;
                PCSrcReg_o  = 1'b0;
                StorePC_o   = 1'b0;
            end
            SType: begin
                Branch_o    = 1'b0;
                ResultSrc_o = 1'b0;
                MemWrite_o  = 1'b1;
                ALUSrc_o    = 1'b1;
                ALUOp_o     = 3'b11;
                ImmSrc_o    = 3'b01;
                RegWrite_o  = 1'b0;
                Jlink_o     = 1'b0;
                PCSrcReg_o  = 1'b0;
                StorePC_o   = 1'b0;
            end
            BType: begin
                Branch_o    = 1'b1;
                ResultSrc_o = 1'b0;
                MemWrite_o  = 1'b0;
                ALUSrc_o    = 1'b0;
                ALUOp_o     = 3'b01;
                ImmSrc_o    = 3'b10;
                RegWrite_o  = 1'b0;
                Jlink_o     = 1'b0;
                PCSrcReg_o  = 1'b0;
                StorePC_o   = 1'b0;
            end
            AddUpp: begin
                Branch_o    = 1'b0;
                ResultSrc_o = 1'b0;
                MemWrite_o  = 1'b0;
                ALUSrc_o    = 1'b0;
                ALUOp_o     = 3'b0;
                ImmSrc_o    = 3'b0;
                RegWrite_o  = 1'b1;
                Jlink_o     = 1'b0;
                PCSrcReg_o  = 1'b0;
                StorePC_o   = 1'b0;
            end
            LoadUpp: begin
                Branch_o    = 1'b0;
                ResultSrc_o = 1'b0;
                MemWrite_o  = 1'b0;
                ALUSrc_o    = 1'b1;
                ALUOp_o     = 3'b100;
                ImmSrc_o    = 3'b100;
                RegWrite_o  = 1'b1;
                Jlink_o     = 1'b0;
                PCSrcReg_o  = 1'b0;
                StorePC_o   = 1'b0;
            end
            JumpLink: begin
                Branch_o    = 1'b0;
                Jlink_o     = 1'b1;
                ResultSrc_o = 1'b0;
                MemWrite_o  = 1'b0;
                ALUSrc_o    = 1'b0;
                ImmSrc_o    = 3'b11;
                RegWrite_o  = 1'b1;
                StorePC_o   = 1'b1;
                PCSrcReg_o  = 1'b0;
                ALUOp_o     = 3'b0;
            end
            JumpLinkReg: begin
                Branch_o    = 1'b0;
                Jlink_o     = 1'b0;
                ResultSrc_o = 1'b0;
                MemWrite_o  = 1'b0;
                ALUSrc_o    = 1'b1;
                ALUOp_o     = 3'b0;
                ImmSrc_o    = 3'b0;
                StorePC_o   = 1'b1;
                PCSrcReg_o  = 1'b1;
                RegWrite_o  = 1'b1;

            end
            default: begin
                Branch_o    = 1'b0;
                ResultSrc_o = 1'b0;
                MemWrite_o  = 1'b0;
                ALUSrc_o    = 1'b0;
                ImmSrc_o    = 3'b0;
                RegWrite_o  = 1'b0;            
                Jlink_o     = 1'b0;
                StorePC_o   = 1'b0;
                PCSrcReg_o  = 1'b0;
                ALUOp_o     = 3'b0;
            end
        endcase
    end

endmodule
