`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 12:54:33
// Design Name: 
// Module Name: tb_signal_extension
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


module tb_signal_extension();
    
    localparam NBITS_O = 11 ;
    localparam NBITS_E = 5  ;
    localparam NBITS_D = 16 ;
    
    reg [NBITS_O-1:0] signal;
    
    initial begin
    signal = 11'b00000000000;
    #5
    signal = 11'b01010101010;
    #5
    signal = 11'b11110101010;
    #5
    signal = 11'b00000101010;
    #5
    signal = 11'b11111111111;
    #20
        
    $display("###############test ok###########");
    $finish;
    end
    
    signal_extension
    #(
        .i_NBITS (NBITS_O),
        .e_NBITS (NBITS_E),
        .o_NBITS (NBITS_D)
    )
    u_signal_extension
    (
        .i_signal (signal)
    );
    
endmodule
