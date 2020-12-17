`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2020 17:08:00
// Design Name: 
// Module Name: data_path
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


module data_path
    #(
        parameter NBITS_O = 11,
        parameter NBITS_E = 5,
        parameter NBITS_D = 16
    )
    (
        input   wire                             i_reset            ,
        input   wire     [1              :0]     i_SelA             ,
        input   wire                             i_SelB             ,
        input   wire                             i_WrAcc            ,
        input   wire                             i_Op               ,   
        input   wire     [NBITS_O-1      :0]     i_Operand          ,
        input   wire     [NBITS_D-1      :0]     i_OutData          ,
        output  wire     [NBITS_D-1      :0]     o_InData                 
    );
    
    reg [NBITS_D-1:0] ivalue;
    reg [NBITS_D-1:0] opeACC;
    reg [NBITS_D-1:0] opeB;
    reg [NBITS_D-1:0] r_ALU;
    
    assign o_InData = opeACC;
    
    signal_extension
    #(
        .i_NBITS            (NBITS_O     ),
        .e_NBITS            (NBITS_E     ),
        .o_NBITS            (NBITS_D     )
    )
    u_signal_extension
    (
        .i_signal           (i_Operand  ),
        .o_ext_signal       (ivalue     )
    );
    
    multiplexores
    #(
        .NBITS_D            (NBITS_D     )
    )
    u_multiplexores
    (
        .i_reset            (i_reset    ),
        .i_SelA             (i_SelA     ),
        .i_SelB             (i_SelB     ),
        .i_WrAcc            (i_WrAcc    ),
        .i_OutData          (i_OutData  ),
        .i_ExtensionData    (ivalue     ),
        .i_ALU              (r_ALU      ),
        .o_ACC              (opeACC     ),
        .o_SelB             (opeB       )                
    );
    
    adder_subtractor
    #(
        .NBITS              (NBITS_D    )
    )
    u_adder_subtractor
    (
        .i_ACC              (opeACC     ),
        .i_SelB             (opeB       ),
        .i_Op               (i_Op       ),
        .o_Result           (r_ALU      )
    );
    
endmodule