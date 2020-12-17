`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2020 07:37:18 PM
// Design Name: 
// Module Name: decoder
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


module decoder
    #(
    )
    (
        input   wire    [4:0]   o_opcode    ,
        output  wire            o_WrPC      ,
        output  wire    [1:0]   o_SelA      ,
        output  wire            o_SelB      ,
        output  wire            o_WrAcc     ,
        output  wire            o_Op        ,   
        output  wire            o_WrRam     ,
        output  wire            o_RdRam
    );

endmodule
