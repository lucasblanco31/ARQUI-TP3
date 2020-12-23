`timescale 1ns / 1ps


module tb_full();

    localparam NBITS_O   =   11;
    localparam NBITS_E   =    5;
    localparam NBITS_D   =   16;
    localparam OPCODE    =    5;
    localparam CELDAS    =   10;
    
    wire        o_halt;
    wire        o_acc;
    
    reg         rst;
    reg         clk;
       
    
    initial begin
      clk     = 1'b0;
      rst       = 1'b1;
      #100
      rst       = 1'b0;
      #1500
      $finish();         
    end
    
    always begin
      #50 
      clk = ~clk;
    end
    
    
    BIP
    #(
        .NBITS_0            (NBITS_O        ),
        .NBITS_E            (NBITS_E        ),
        .NBITS_D            (NBITS_D        ),
        .OPCODE             (OPCODE         ),
        .CELDAS             (CELDAS         )
    )
    u_BIP
    (
        .i_clk              (clk            ),
        .i_reset            (rst            ),
        .o_Halt             (o_halt         ),
        .o_ACC              (o_acc          )              
    );
    
endmodule
 
