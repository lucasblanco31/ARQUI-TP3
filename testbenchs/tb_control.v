`timescale 1ns / 1ps
module controlTB();
    localparam NBITS_O = 11;
    localparam NBITS_E = 5;
    localparam NBITS_D = 16;
    localparam OPCODE  = 5;  
    localparam CELDAS  = 10;
    
    reg             i_clk;
    reg             rst;
    
    wire     [NBITS_D-1     :0]      instruction;
    wire     [NBITS_O-1     :0]      addr;
    
    wire     [1             :0]      SelA        ;
    wire                             SelB        ;
    wire                             WrAcc       ;
    wire                             Op          ;
    wire                             WrRam       ;
    wire                             RdRam       ;
    wire     [NBITS_O-1     :0]      Operand     ;
    
        
    initial begin
      i_clk     = 1'b0;
      rst       = 1'b1;
      #100
      rst       = 1'b0;
      #1100
      $finish();         
    end
    
    always begin
      #50 
      i_clk = ~i_clk;
    end
        
        
    control
    #(
        .NBITS_0            (NBITS_O        ),
        .NBITS_D            (NBITS_D        ),
        .OPCODE             (OPCODE         )
    )
    u_control
    (
        .i_clk              (i_clk          ),
        .i_reset            (rst            ),
        .i_Instruction      (instruction    ),
        .o_Addr             (addr           ),
        .o_SelA             (SelA           ),
        .o_SelB             (SelB           ),
        .o_WrAcc            (WrAcc          ),
        .o_Op               (Op             ),
        .o_WrRam            (WrRam          ),
        .o_RdRam            (RdRam          ),
        .o_Operand          (Operand        )
    );
    
   programMemory
   #(
        .NBITS_O        (NBITS_O    ),
        .NBITS_D        (NBITS_D    ),
        .CELDAS         (CELDAS     )   
   )
   u_programMemory
   (
        .i_reset        (rst        ),
        .i_Addr         (addr       ),
        .o_Data         (instruction)
   );
    
endmodule
 
