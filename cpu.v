`timescale 1ns / 1ps

module cpu
    #(
        parameter NBITS_O = 11  ,
        parameter NBITS_E = 5   ,
        parameter NBITS_D = 16  ,
        parameter OPCODE  = 5                   
    )
    (
        input   wire                            i_clk           ,
        input   wire                            i_reset         ,
        input   wire    [NBITS_D-1     :0]      i_Instruction   ,
        input   wire    [NBITS_D-1     :0]      i_OutData       ,
        output  wire    [NBITS_O-1     :0]      o_PmAddr        ,
        output  wire    [NBITS_O-1     :0]      o_DmAddr        ,
        output  wire                            o_Rd            ,
        output  wire                            o_Wr            ,
        output  wire    [NBITS_D-1     :0]      o_InData                       
    );
    
    wire     [NBITS_O-1     :0]      PmAddr      ;
    wire     [NBITS_O-1     :0]      DmAddr      ;
    wire     [1             :0]      SelA        ;
    wire                             SelB        ;
    wire                             WrAcc       ;
    wire                             Op          ;
    wire                             WrRam       ;
    wire                             RdRam       ;
    wire     [NBITS_O-1     :0]      Operand     ;                              
    
    assign o_PmAddr = PmAddr    ;
    assign o_Rd     = RdRam     ;
    assign o_Wr     = WrRam     ;
    assign o_DmAddr = Operand   ;
    
    
    control
    #(
        .NBITS_0            (NBITS_O        ),
        .NBITS_D            (NBITS_D        ),
        .OPCODE             (OPCODE         )
    )
    u_control
    (
        .i_clk              (i_clk          ),
        .i_reset            (i_reset        ),
        .i_Instruction      (i_Instruction  ),
        .o_Addr             (PmAddr         ),
        .o_SelA             (SelA           ),
        .o_SelB             (SelB           ),
        .o_WrAcc            (WrAcc          ),
        .o_Op               (Op             ),
        .o_WrRam            (WrRam          ),
        .o_RdRam            (RdRam          ),
        .o_Operand          (Operand        )
    );
    
    datapath
    #(
        .NBITS_O            (NBITS_O        ),
        .NBITS_E            (NBITS_E        ),
        .NBITS_D            (NBITS_D        )
    )
    u_datapath
    (
        .i_reset            (i_reset        ),
        .i_SelA             (SelA           ),
        .i_SelB             (SelB           ),
        .i_WrAcc            (WrAcc          ),
        .i_Op               (Op             ),
        .i_Operand          (Operand        ),
        .i_OutData          (i_OutData      ),
        .o_InData           (o_InData       )
    );
    
endmodule
