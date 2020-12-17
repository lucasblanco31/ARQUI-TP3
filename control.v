`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2020 17:40:30
// Design Name: 
// Module Name: control
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


module control
    #(
        parameter NBITS_0 = 11,
        parameter NBITS_D = 16,
        parameter OPCODE  = 5
    )
    (
        input   wire                             i_reset         ,
        input   wire     [NBITS_D-1     :0]      i_Instruction   ,
        output  wire     [NBITS_0-1     :0]      o_Addr          ,
        output  wire     [1             :0]      o_SelA          ,
        output  wire                             o_SelB          ,
        output  wire                             o_WrAcc         ,
        output  wire                             o_Op            ,
        output  wire                             o_WrRam         ,
        output  wire                             o_RdRam         ,   
        output  wire     [NBITS_0-1      :0]     o_Operand            
    );
    
    reg [NBITS_0-1  :0] pc;
    reg [NBITS_0-1  :0] pc_reg;
    wire wr_pc; 
    
    assign o_Addr       =   pc_reg;
    assign o_Operand    =   i_Instruction[NBITS_D-OPCODE-1:0];
    
    always @(*)
    begin
        if(i_reset)
        begin
            pc              <=      {NBITS_D{1'b0}}         ;
            pc_reg          <=      {NBITS_D{1'b0}}         ;
        end
        else if(wr_pc) 
            pc_reg          <=      pc          +       1   ;
    end
    
    
    decoder
    #(
        .OPCODE              (OPCODE     )
    )
    u_decoder
    (
        .i_opcode       (i_Instruction[NBITS_D-1    :NBITS_D-OPCODE]),
        .o_WrPC         (wr_pc                                      ),
        .o_SelA         (o_SelA                                     ),
        .o_SelB         (o_SelB                                     ),
        .o_WrAcc        (o_WrAcc                                    ),
        .o_Op           (o_Op                                       ),   
        .o_WrRam        (o_WrRam                                    ),
        .o_RdRam        (o_RdRam                                    )
    );
    
endmodule
