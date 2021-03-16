`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 13:16:53
// Design Name: 
// Module Name: tb_multiplexores
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


module tb_multiplexores();
    
    localparam NBITS = 16;
    
    reg                 reset           ;
    reg     [1      :0] SelA            ;
    reg                 SelB            ;
    reg                 WrACC           ;
    reg     [NBITS-1:0] OutData         ;
    reg     [NBITS-1:0] ExtensionData   ;
    wire    [NBITS-1:0] ALU             ;
    wire    [NBITS-1:0] ACC             ;
    wire    [NBITS-1:0] B               ;
    reg                 Op              ;
    
    initial begin
    reset = 1'b1;
    #1
    reset = 1'b0;
    OutData = 16'b0000111100001111;
    ExtensionData = 16'b0000000000001111;
    #2
    WrACC = 1'b1;
    Op = 1'b0;
    SelA = 2'b10;
    SelB = 1'b0;
    #30
    
    $display("###########test ok##############");
    $finish;
    end
    multiplexores
    #(
        .NBITS_D            (NBITS          )
    )
    u_multiplexores
    (
        .i_reset            (reset          ),
        .i_SelA             (SelA           ),
        .i_SelB             (SelB           ),
        .i_WrAcc            (WrACC          ),
        .i_OutData          (OutData        ),
        .i_ExtensionData    (ExtensionData  ),
        .i_ALU              (ALU            ),
        .o_ACC              (ACC            ),
        .o_SelB             (B              )
    );
    adder_subtractor
    #(
        .NBITS      (NBITS   )
    )
    u_adder_subtractor
    (
        .i_ACC      (ACC    ),
        .i_SelB     (B      ),
        .i_Op       (Op     ),
        .o_Result   (ALU    )
    );   
endmodule
