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
        parameter CELDAS  = 10
    )
    (
        input   wire                        i_clk       ,
        input   wire                        i_reset     ,
        input   wire                        i_Rd        ,
        input   wire                        i_Wr        ,
        input   wire    [NBITS_O-1  :0]     i_Addr      ,
        input   wire    [NBITS_D-1  :0]     i_InData    ,
        output  wire    [NBITS_D-1  :0]     o_OutData      
    );
    
    reg     [NBITS_D-1  :0]     data;
    reg     [NBITS_D-1  :0]     memory[CELDAS-1 :0];
    
    initial begin
    memory[0] = 16'h0000 ;
    memory[1] = 16'h0001 ;
    memory[2] = 16'h0002 ;
    memory[3] = 16'h0003 ;
    memory[4] = 16'h0004 ;
    memory[5] = 16'h0005 ;
    memory[6] = 16'h0006 ;
    memory[7] = 16'h0007 ;
    memory[8] = 16'h0008 ;
    memory[9] = 16'h0009 ;
    end
    
    assign o_OutData = data;
    
    always @(negedge i_clk)
    begin
        if(i_reset)
        begin
            data            <=      {NBITS_D{1'b0}} ;
            memory[0]       <=      16'h0000        ;
            memory[1]       <=      16'h0001        ;
            memory[2]       <=      16'h0002        ;
            memory[3]       <=      16'h0003        ;
            memory[4]       <=      16'h0004        ;
            memory[5]       <=      16'h0005        ;
            memory[6]       <=      16'h0006        ;
            memory[7]       <=      16'h0007        ;
            memory[8]       <=      16'h0008        ;
            memory[9]       <=      16'h0009        ;
        end           
            
        else if(i_Wr)
            memory[i_Addr]  <=      i_InData        ;
            
        else if(i_Rd)
            data            <=      memory[i_Addr]  ;
            
        else
            data            <=      data            ;
    end
endmodule
