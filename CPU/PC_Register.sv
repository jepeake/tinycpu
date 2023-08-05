module PC_Register #(
    parameter WIDTH = 32
)(
    // interface signals
    input logic                 clk,          //clock
    input logic                 rst,          //reset
    input logic  [WIDTH-1:0]    PC_Next_i,    //PC Input 
    output logic [WIDTH-1:0]    PC_o          //PC Output
);

always_ff @ (posedge clk)
    if (rst) PC_o <= {WIDTH{1'b0}};       
    else     PC_o <= PC_Next_i;
    
endmodule
