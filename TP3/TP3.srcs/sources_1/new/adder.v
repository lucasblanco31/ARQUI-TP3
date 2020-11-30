`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2020 01:15:25 PM
// Design Name: 
// Module Name: adder
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


module adder
    #(
        parameter NBITS = 11
    )
    (
        input   wire    signed  [NBITS-1:0] i_pc,
        output  wire    signed  [NBITS-1:0] o_pc_next
    );
                reg     signed  [NBITS-1:0] result_ope_reg;
                
    assign o_pc_next = result_ope_reg;
    
    always @(*)
        begin : next_pc
            result_ope_reg  =   i_pc    +   1   ;
        end
endmodule