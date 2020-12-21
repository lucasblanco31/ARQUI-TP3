`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2020 20:56:26
// Design Name: 
// Module Name: programMemory
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


module programMemory
    #(
        parameter NBITS_O = 11,
        parameter NBITS_D = 16,
        parameter CELDAS  = 512
    )
    (
        input   wire                        i_reset     ,
        input   wire    [NBITS_O-1  :0]     i_Addr      ,
        output  wire    [NBITS_D-1  :0]     o_Data      
    );
    
    reg     [NBITS_D-1  :0]     data;
    reg     [NBITS_D-1  :0]     memory[CELDAS-1 :0];
    
    //  | 15 Opcode 11 | 10 Operand 0 | Instruction format
    /*
    initial begin
    mem_bank[0] = 16'b00010_000_0000_0001 ; //Load variable 0x01 => ACC=0x01
    mem_bank[1] = 16'b00101_000_0000_0010 ; //Add immediate +0x2 => ACC=0x03
    mem_bank[2] = 16'b00001_000_0000_0111 ; //Store in 0x7 => ACC=0x03
    mem_bank[3] = 16'b00011_000_0000_1000 ; //Load immediate 0x08 => ACC=0x08
    mem_bank[4] = 16'b00110_000_0000_0010 ; //Substract variable in 0x02 => ACC=0x06  
    mem_bank[5] = 16'b00100_000_0000_0010 ; //Add variable in 0x02 => ACC=0x08
    mem_bank[6] = 16'b00001_000_0000_0100 ; //Store in 0xB => ACC=0x08
    mem_bank[7] = 16'b00011_000_0000_0011 ; //Load immediate 0x03 => ACC=0x03
//    mem_bank[9] = 16'b00111_000_0000_0011 ; //Substract immediate 0x03 => ACC=0x00
    mem_bank[9] = 16'b00000_000_0000_0000 ; // Halt
    mem_bank[8] = 16'b00011_000_0000_1000 ; //Load immediate 0x08 => ACC=0x08
    end
    */
    assign o_Data = data;
    
    always @(*)
    begin
        if(i_reset)
            data            <=      memory[0]       ;     
        else
            data            <=      memory[i_Addr]  ;
    end
endmodule

