`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 14:57:25
// Design Name: 
// Module Name: tb_datapath
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


module tb_datapath();
    
    localparam NBITSO = 11;
    localparam NBITSE = 5;
    localparam NBITSD = 16;
    
    reg                 clock   ;
    reg                 reset   ;
    reg [1         :0]  SelA    ;
    reg                 SelB    ;
    reg                 WrAcc   ;
    reg                 Op      ;
    reg [NBITSO-1  :0]  Operand ;
    reg [NBITSD-1  :0]  OutData ;
    
    initial begin
    clock = 1'b0;
    reset = 1'b1;
    #1
    reset = 1'b0;
    //WrAcc = 1'b1;
    Op = 1'b0;
    Operand = 11'b00001111011;
    OutData = 16'b1111000011110000;
    
    #2
    SelA = 2'b00;
    SelB = 1'b0;
    #5
    WrAcc = 1'b1;
    #2
    WrAcc = 1'b0; 
    #2
    SelB = 1'b1;
    #2
    SelA = 2'b01;
    #5
    WrAcc = 1'b1;
    #2
    WrAcc = 1'b0;
    #2
    SelA = 2'b10;
    #15
    WrAcc = 1'b1;
    #1
    WrAcc = 1'b0;
    #1000
    $display("#############test ok##############");
    $finish;
    end
    always 
    begin
    #1
    clock = ~clock;            
    end

    
    datapath 
    #(
        .NBITS_O    (NBITSO     ),
        .NBITS_E    (NBITSE     ),
        .NBITS_D    (NBITSD     )
    )
    u_datapath
    (
        .i_clock    (clock      ), 
        .i_reset    (reset      ),
        .i_SelA     (SelA       ),
        .i_SelB     (SelB       ),
        .i_WrAcc    (WrAcc      ),
        .i_Op       (Op         ),
        .i_Operand  (Operand    ),
        .i_OutData  (OutData    )
    );
        
endmodule
