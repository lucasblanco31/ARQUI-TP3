`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2020 16:27:34
// Design Name: 
// Module Name: multiplexores
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


module multiplexores
    #(
        //parameter NBITS_O = 11,
        parameter NBITS_D = 16
    )
    (
        input   wire                             i_reset            ,
        input   wire     [1              :0]     i_SelA             ,
        input   wire                             i_SelB             ,
        input   wire                             i_WrAcc            ,
        //input   wire                             i_Op               ,   
        //input   wire     [NBITS_O-1      :0]     i_Operand          ,
        input   wire     [NBITS_D-1      :0]     i_OutData          ,
        input   wire     [NBITS_D-1      :0]     i_ExtensionData    ,
        input   wire     [NBITS_D-1      :0]     i_ALU              ,
        output  wire     [NBITS_D-1      :0]     o_ACC              ,
        output  wire     [NBITS_D-1      :0]     o_SelB                 
    );
    
    reg [NBITS_D-1  :0] ACC;
    reg [NBITS_D-1  :0] SELB;
    
    always @(*)
    begin
        if(i_reset)
                            ACC     <=      {NBITS_D{1'b0}}   ;
        else if(i_WrAcc)
            begin
                case(i_SelA)
                    2'b00:  ACC     <=      i_OutData         ;
                    2'b01:  ACC     <=      i_ExtensionData   ;
                    2'b10:  ACC     <=      i_ALU             ;
                    2'b11:  ACC     <=      ACC               ;
                endcase
            end
    end
    
    always @(*)
    begin
        if(i_reset)
                    SELB    <=      {NBITS_D{1'b0}}     ;  
        else
            begin
                case(i_SelB)
                    1'b0:   SELB    <=      i_OutData           ;   
                    1'b1:   SELB    <=      i_ExtensionData     ;
                endcase
            end
    end
    
    assign  o_ACC   =   ACC;
    assign  o_SelB  =   SELB;
       
    
endmodule
