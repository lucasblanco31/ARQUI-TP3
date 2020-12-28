`timescale 1ns / 1ps
/*
M = ((1/(baudRate))/ticks)/(1/clockFrec)
    ((1/19200)/16)/(1/10000000)
*/

module mod_m_counter  
   #(  
    parameter   N=4, // number of bits in counter 1111   
    parameter   M=15 // mod-M  
   )  
   (  
    input   wire            i_clk,
    input   wire            i_reset,  
    output  wire            o_max_tick  
   );  
   //signal declaration  
   reg      [N-1:0]     r_reg;  
   wire     [N-1:0]     r_next;  
          
   // body  
   // register  
   //posedge transition from 0 to 1, negedge transition from 1 to 0   
    always @(posedge i_clk, posedge i_reset)  
        if (i_reset)  
            r_reg <= 0;  
        else  
            r_reg <= r_next;  
    // next-state logic      true  false  
    assign r_next = (r_reg==(M-1)) ? 0 : r_reg + 1;  
   // output logic  
      //end of the count?        true  false             
   assign o_max_tick = (r_reg==(M-1)) ? 1'b1 : 1'b0;  
 endmodule  

    