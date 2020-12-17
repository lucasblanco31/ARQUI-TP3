`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2020 01:22:43 PM
// Design Name: 
// Module Name: pc
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


module pc
    #(
        parameter   NBITS = 11
    )
    (
        input       wire    signed  [NBITS-1:0] i_pc_next,
        input       wire                        i_wr_pc,
        input       wire                        i_reset,
        output      wire    signed  [NBITS-1:0] o_pc
    );
    
    always @(*)
        begin 
            result_ope_reg  =   i_pc    +   1   ;
        end
    
endmodule
