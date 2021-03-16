`timescale 1ns / 1ps

module control
    #(
        parameter NBITS_0 = 11,
        parameter NBITS_D = 16,
        parameter OPCODE  = 5
    )
    (
        input   wire                             i_clk           ,
        input   wire                             i_reset         ,
        input   wire     [NBITS_D-1     :0]      i_Instruction   ,
        output  wire     [NBITS_0-1     :0]      o_Addr          ,
        output  wire     [1             :0]      o_SelA          ,
        output  wire                             o_SelB          ,
        output  wire                             o_WrAcc         ,
        output  wire                             o_Op            ,
        output  wire                             o_WrRam         ,
        output  wire                             o_RdRam         ,   
        output  wire     [NBITS_0-1      :0]     o_Operand       ,
        output  wire                             o_Halt             
    );
    
    reg         [NBITS_0-1  :0]         pc_reg;
    wire                                wr_pc; 
    wire        [OPCODE-1   :0]         o_Opcode;
    
    assign o_Addr       =   pc_reg;
    assign o_Operand    =   i_Instruction[NBITS_D-OPCODE-1 :0             ];
    assign o_Opcode     =   i_Instruction[NBITS_D-1        :NBITS_D-OPCODE];
    
    always @(negedge i_clk)
    begin
        if(i_reset)
        begin
            pc_reg          <=      {NBITS_D{1'b0}}         ;
        end
        else if(wr_pc) 
            pc_reg          <=      pc_reg          +      1;
    end
    
    
    decoder
    #(
        .OPCODE              (OPCODE     )
    )
    u_decoder
    (
        .i_Opcode       (o_Opcode                                   ),
       // .i_rst          (i_reset                                    ),
        .o_WrPC         (wr_pc                                      ),
        .o_SelA         (o_SelA                                     ),
        .o_SelB         (o_SelB                                     ),
        .o_WrAcc        (o_WrAcc                                    ),
        .o_Op           (o_Op                                       ),   
        .o_WrRam        (o_WrRam                                    ),
        .o_RdRam        (o_RdRam                                    ),
        .o_Halt         (o_Halt                                     )
    );
    
endmodule
