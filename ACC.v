`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 15:53:02
// Design Name: 
// Module Name: ACC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ACC
#(
    parameter NBITS_D = 16
)
(
    input   wire                i_clk     ,
    input   wire                i_reset     ,
    input   wire [NBITS_D-1:0]  i_ACC       ,
    input   wire                i_WrAcc     ,
    output  wire [NBITS_D-1:0]  o_ACC
);
   reg  [NBITS_D-1:0] ACC;
   
   assign o_ACC = ACC;
      
   always @(posedge i_clk) 
   begin
    if (i_reset)
        ACC  <= {NBITS_D{1'b0}};
    
    else if (i_WrAcc) 
        ACC  <= i_ACC;
        
    else
        ACC  <= ACC;
   end
endmodule
