`timescale 1ns / 1ps
/////////////////////////////////////////////////////

//Definicion de Macros mediante directiva 'define'
//<nombre>	<tamao>' <base>
`define	HLT	    5'b00000	//Halt
`define	STO	    5'b00001	//Store Variable
`define	LD	    5'b00010	//Load Variable
`define	LDI	    5'b00011	//Load Inmediate
`define	ADD	    5'b00100	//Add Variable
`define	ADDI	5'b00101	//Add Inmediate
`define	SUB	    5'b00110	//Subtract Variable
`define	SUBI    5'b00111	//Subtract Inmediate

module decoder
    #(
        parameter OPCODE = 5
    )
    (
        input   wire    [OPCODE-1   :0]     i_Opcode    ,
        output  reg                         o_WrPC      ,
        output  reg     [1          :0]     o_SelA      ,
        output  reg                         o_SelB      ,
        output  reg                         o_WrAcc     ,
        output  reg                         o_Op        ,   
        output  reg                         o_WrRam     ,
        output  reg                         o_RdRam     ,
        output  reg                         o_Halt         
    );
    
    always @(*) begin
        case(i_Opcode)
            `HLT:
            begin
                o_WrPC      = 1'b0      ;
                o_SelA      = 2'b11     ;
                o_SelB      = 1'b0      ;
                o_WrAcc     = 1'b0      ;
                o_Op        = 1'b0      ;
                o_WrRam     = 1'b0      ;
                o_RdRam     = 1'b0      ;
                o_Halt      = 1'b1      ;    
            end
            `STO: //DM[operand] ← ACC
            begin
                o_WrPC      = 1'b1      ;
                o_SelA      = 2'b11     ;
                o_SelB      = 1'b0      ;
                o_WrAcc     = 1'b0      ;
                o_Op        = 1'b0      ;
                o_WrRam     = 1'b1      ;
                o_RdRam     = 1'b0      ;
                o_Halt      = 1'b0      ;    
            end
            `LD: //ACC ← DM[operand]
            begin
                o_WrPC      = 1'b1      ;
                o_SelA      = 2'b00     ;
                o_SelB      = 1'b0      ;
                o_WrAcc     = 1'b1      ;
                o_Op        = 1'b0      ;
                o_WrRam     = 1'b0      ;
                o_RdRam     = 1'b1      ;
                o_Halt      = 1'b0      ;    
            end
            `LDI: //ACC ← operand
            begin
                o_WrPC      = 1'b1      ;
                o_SelA      = 2'b01     ;
                o_SelB      = 1'b0      ;
                o_WrAcc     = 1'b1      ;
                o_Op        = 1'b0      ;
                o_WrRam     = 1'b0      ;
                o_RdRam     = 1'b0      ;
                o_Halt      = 1'b0      ;    
            end
            `ADD: //ACC ← ACC + DM[operand]
            begin
                o_WrPC      = 1'b1      ;
                o_SelA      = 2'b10     ;
                o_SelB      = 1'b0      ;
                o_WrAcc     = 1'b1      ;
                o_Op        = 1'b0      ; //suma
                o_WrRam     = 1'b0      ;
                o_RdRam     = 1'b1      ;
                o_Halt      = 1'b0      ;    
            end
            `ADDI: //ACC ← ACC + operand
            begin
                o_WrPC      = 1'b1      ;
                o_SelA      = 2'b10     ;
                o_SelB      = 1'b1      ;
                o_WrAcc     = 1'b1      ;
                o_Op        = 1'b0      ; //suma
                o_WrRam     = 1'b0      ;
                o_RdRam     = 1'b0      ;
                o_Halt      = 1'b0      ;    
            end
            `SUB: //ACC ← ACC - DM[operand]
            begin
                o_WrPC      = 1'b1      ;
                o_SelA      = 2'b10     ;
                o_SelB      = 1'b0      ;
                o_WrAcc     = 1'b1      ;
                o_Op        = 1'b1      ; //RESTA
                o_WrRam     = 1'b0      ;
                o_RdRam     = 1'b1      ;
                o_Halt      = 1'b0      ;    
            end
            `SUBI: //ACC ← ACC - operand
            begin
                o_WrPC      = 1'b1      ;
                o_SelA      = 2'b10     ;
                o_SelB      = 1'b1      ;
                o_WrAcc     = 1'b1      ;
                o_Op        = 1'b1      ; //RESTA
                o_WrRam     = 1'b0      ;
                o_RdRam     = 1'b0      ;
                o_Halt      = 1'b0      ;    
            end
            default:
            begin
                o_WrPC      = 1'b0      ;
                o_SelA      = 2'b11     ;
                o_SelB      = 1'b0      ;
                o_WrAcc     = 1'b0      ;
                o_Op        = 1'b0      ;
                o_WrRam     = 1'b0      ;
                o_RdRam     = 1'b0      ;
                o_Halt      = 1'b0      ;    
            end
        endcase
    end
endmodule
