`timescale 1ns / 1ps


module programMemory
    #(
        parameter NBITS_O = 11,
        parameter NBITS_D = 16,
        parameter CELDAS  = 10
    )
    (
        input   wire                        i_clk       ,
        input   wire                        i_reset     ,
        input   wire    [NBITS_O-1  :0]     i_Addr      ,
        output  wire    [NBITS_D-1  :0]     o_Data      
    );
    
    reg     [NBITS_D-1  :0]     data;
    reg     [NBITS_D-1  :0]     memory[CELDAS-1 :0];
    
    assign o_Data = data;
    
    always @(posedge i_clk)
    begin
        if(i_reset)
        begin
            memory[0]       <=      16'b00010_000_0000_0001 ; //Load variable 0x01 => ACC=0x01
            memory[1]       <=      16'b00101_000_0000_0010 ; //Add immediate +0x2 => ACC=0x03
            memory[2]       <=      16'b00001_000_0000_0111 ; //Store in 0x7 => ACC=0x03
            memory[3]       <=      16'b00011_000_0000_1000 ; //Load immediate 0x08 => ACC=0x08
            memory[4]       <=      16'b00110_000_0000_0010 ; //Substract variable in 0x02 => ACC=0x06  
            memory[5]       <=      16'b00100_000_0000_0011 ; //Add variable in 0x03 => ACC=0x09
            memory[6]       <=      16'b00001_000_0000_1000 ; //Store in 0x0B => ACC=0x08
            memory[7]       <=      16'b00011_000_0000_0011 ; //Load immediate 0x03 => ACC=0x03
            memory[8]       <=      16'b00010_000_0000_1000 ; //Load variable 0x08 => ACC=0x09
            memory[9]       <=      16'b00000_000_0000_0000 ; // Halt    
        end   
        else
            data            <=      memory[i_Addr]  ;
    end
endmodule

