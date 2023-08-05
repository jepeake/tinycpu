module DataMem #(
    parameter   ADDRESS_WIDTH = 32,
                DATA_WIDTH = 32,
                BYTE_WIDTH = 8
)(
    input  logic                         clk,
    input  logic                         we,
    input  logic                         ByteOp,
    input  logic [ADDRESS_WIDTH-1:0]     Address,
    input  logic [DATA_WIDTH-1:0]        WriteData,
    output logic [DATA_WIDTH-1:0]        ReadData
);

    logic [BYTE_WIDTH-1:0] ram_array [32'h0001FFFF:32'h00000000];   // set mem size

    initial begin
        $readmemh("gaussian.mem", ram_array, 32'h10000);
    end;

    always_ff @(posedge clk) begin
        if (we && !ByteOp) begin                 
            ram_array[{Address[31:2], 2'b0}]   <= WriteData[31:24];       // Big endian storage  
            ram_array[{Address[31:2], 2'b0}+1] <= WriteData[23:16];
            ram_array[{Address[31:2], 2'b0}+2] <= WriteData[15:8];
            ram_array[{Address[31:2], 2'b0}+3] <= WriteData[7:0];
        end
        else if (we && ByteOp) begin
            ram_array[Address] <= WriteData[7:0];
        end
    end

    always_comb begin
        if (ByteOp) begin
            ReadData = {24'b0, ram_array[Address]};
        end
        else begin
            ReadData = {ram_array[{Address[31:2], 2'b0}], 
                        ram_array[{Address[31:2], 2'b0}+1], 
                        ram_array[{Address[31:2], 2'b0}+2], 
                        ram_array[{Address[31:2], 2'b0}+3]};
        end
    end

endmodule
