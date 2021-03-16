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
        parameter NBITS_D = 16
    )
    (
        input   wire     [1              :0]     i_SelA             ,
        input   wire                             i_SelB             ,
        input   wire     [NBITS_D-1      :0]     i_OutData          ,
        input   wire     [NBITS_D-1      :0]     i_ExtensionData    ,
        input   wire     [NBITS_D-1      :0]     i_ALU              ,
        output  wire     [NBITS_D-1      :0]     o_ACC              ,
        output  wire     [NBITS_D-1      :0]     o_SelB                 
    );
    
    localparam [1:0]    
                        Memory      = 2'b00,                   
                        Extension   = 2'b01,                   
                        ALU         = 2'b10;     
    
    reg [NBITS_D-1  :0] to_ACC;
    reg [NBITS_D-1  :0] SELB;
    
    assign  o_ACC   =   to_ACC;
    assign  o_SelB  =   SELB;

    
    always @(*)
    begin    
        case(i_SelA)
            Memory:
                to_ACC     <=      i_OutData         ;
            Extension:  
                to_ACC     <=      i_ExtensionData   ;
            ALU:  
                to_ACC     <=      i_ALU             ;
            default:  
                to_ACC     <=      {NBITS_D,1'b0}    ;
        endcase
    end
    
    always @(*)
    begin
        case(i_SelB)
                    1'b0:   SELB    <=      i_OutData           ;   
                    1'b1:   SELB    <=      i_ExtensionData     ;
        endcase
    end      
endmodule
