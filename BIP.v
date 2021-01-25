`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2020 21:01:21
// Design Name: 
// Module Name: BIP
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


module bip
    #(
        parameter NBITS_O   =   11  ,
        parameter NBITS_E   =   5   ,
        parameter NBITS_D   =   16  ,
        parameter OPCODE    =   5   ,
        parameter CELDAS    =   10
    )
    (
        input   wire                    i_clk   ,
        input   wire                    i_reset ,
        output  wire                    o_Halt  ,
        output  wire [NBITS_D-1  :0]    o_ACC     
    );
  
    //reg                 clock   ;
    wire [NBITS_O-1:0]  PmAddr  ;
    wire [NBITS_D-1:0]  Data    ;
    wire                Rd      ;
    wire                Wr      ;
    wire [NBITS_O-1:0]  DmAddr  ;
    wire [NBITS_D-1:0]  InData  ;
    wire [NBITS_D-1:0]  OutData ;
    
    assign o_ACC = InData;
    
    cpu
    #(
        .NBITS_O        (NBITS_O),
        .NBITS_E        (NBITS_E),
        .NBITS_D        (NBITS_D),
        .OPCODE         (OPCODE)
    )
    u_cpu
    (
        .i_clk          (i_clk      ),
        .i_reset        (i_reset    ),
        .i_Instruction  (Data       ),
        .i_OutData      (OutData    ),
        .o_PmAddr       (PmAddr     ),
        .o_DmAddr       (DmAddr     ),
        .o_Rd           (Rd         ),
        .o_Wr           (Wr         ),
        .o_InData       (InData     ),
        .o_Halt         (o_Halt     )
    );
    
   programMemory
   #(
        .NBITS_O        (NBITS_O    ),
        .NBITS_D        (NBITS_D    ),
        .CELDAS         (CELDAS     )   
   )
   u_programMemory
   (
        .i_clk          (i_clk      ),
        //.i_reset        (i_reset    ),
        .i_Addr         (PmAddr     ),
        .o_Data         (Data       )
   );
   
   datamemory
   #(
        .NBITS_O        (NBITS_O    ),
        .NBITS_D        (NBITS_D    ),
        .CELDAS         (CELDAS     )
   )
   u_datamemory
   (
        .i_clk          (i_clk      ),
        .i_reset        (i_reset    ),
        .i_Rd           (Rd         ),
        .i_Wr           (Wr         ),
        .i_Addr         (DmAddr     ),
        .i_InData       (InData     ),
        .o_OutData      (OutData    )
   );
endmodule
