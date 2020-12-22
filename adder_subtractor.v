`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2020 07:47:41 PM
// Design Name: 
// Module Name: adder_subtractor
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

module adder_subtractor
    #(
        parameter NBITS = 16
    )
    (
        input   wire    [NBITS-1:0]     i_ACC       ,
        input   wire    [NBITS-1:0]     i_SelB      ,
        input   wire                    i_Op        ,
        output  wire    [NBITS-1:0]     o_Result    
    );
    reg [NBITS-1:0] result_ope_reg;
                
    assign o_Result = result_ope_reg;
    
    always @(*)
        begin : operaciones
            case(i_Op)
                1'b0:       result_ope_reg  =    i_ACC  +   i_SelB   ;
                1'b1:       result_ope_reg  =    i_ACC  -   i_SelB   ;
            endcase
        end
endmodule