module DataMem #(
    parameter   ADDRESS_WIDTH = 32,
                DATA_WIDTH = 32
)(
    input  logic                         clk,
    input  logic                         we,
    input  logic [ADDRESS_WIDTH-1:0]     Address,
    input  logic [DATA_WIDTH-1:0]        WriteData,
    output logic [DATA_WIDTH-1:0]        ReadData
);

    logic [DATA_WIDTH-1:0] ram_array [2**16-1:0];

    always_ff @(posedge clk) begin
        if (we == 1'b1)
            ram_array[{2'b0, Address[31:2]}] <= WriteData;
    end

    always_comb begin
            ReadData = ram_array[{2'b0, Address[31:2]}];
    end

endmodule
