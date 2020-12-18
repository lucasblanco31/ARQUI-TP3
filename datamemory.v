`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2020 11:37:50
// Design Name: 
// Module Name: datamemory
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


module datamemory
    #(
        parameter NBITS_O = 11,
        parameter NBITS_D = 16,
        parameter CELDAS  = 512
    )
    (
        input   wire                        i_reset     ,
        input   wire                        i_Rd        ,
        input   wire                        i_Wr        ,
        input   wire    [NBITS_O-1  :0]     i_Add       ,
        input   wire    [NBITS_D-1  :0]     i_InData    ,
        output  wire    [NBITS_D-1  :0]     o_OutData      
    );
    
    reg     [NBITS_D-1  :0]     data;
    reg     [NBITS_D-1  :0]     memory[CELDAS-1 :0];
    
    assign o_OutData = data;
    
    always @(*)
    begin
        if(i_reset)
            data            <=      {NBITS_D{1'b0}} ;
            
        else if(i_Wr)
            memory[i_Add]   <=      i_InData        ;
            
        else if(i_Rd)
            data            <=      memory[i_Add]   ;
    end
endmodule
