`timescale 1ns / 1ps

module top
    #(
        //BIP PARAMETERS
        parameter   NBITS_O   =   11,
        parameter   NBITS_E   =    5,
        parameter   NBITS_D   =   16,
        parameter   OPCODE    =    5,
        parameter   CELDAS    =   10,
        //UART PARAMETERS
        parameter   DBIT      =    8,
        parameter   SBTICK    =   16,
        parameter   SIZ       =    8,
        parameter   DIV       =    6 //10Mhz -> 115000baudrate
    )
    (
        input       wire        i_clk,
        input       wire        i_rst,
        output      wire        o_tx
    );
      
    wire                            o_halt;
    wire        [NBITS_D-1  :0]     o_acc;    
    
    wire                             i_stick;
    wire                             o_stick; 
    wire                             tx_done;
    
    reg                              i_start;
    reg         [DBIT-1 :0]          i_data;
    
    reg         [NBITS_D:0]          acc;
    
    reg                              count;
       
   
    always @(posedge i_clk)
    begin
        case(count)
            1'b0:
                begin
                    if(o_halt)
                    begin
                        acc     =   o_acc;
                        i_data  =   acc[DBIT-1:   0];
                        i_start =   1'b1;
                        count   =   count + 1;
                    end
                end
            1'b1:
                begin
                    i_start     =   1'b0;
                    if(tx_done)
                    begin
                        i_data  =   acc[NBITS_D-1: DBIT];
                        i_start =   1'b1;
                        count   =   count + 1;
                    end
                end
            default:
                begin
                    i_start     =   1'b0;
                    count       =   1'b0;
                end
        endcase
    end    
    
    bip
    #(
        .NBITS_O            (NBITS_O        ),
        .NBITS_E            (NBITS_E        ),
        .NBITS_D            (NBITS_D        ),
        .OPCODE             (OPCODE         ),
        .CELDAS             (CELDAS         )
    )
    u_bip
    (
        .i_clk              (i_clk          ),
        .i_reset            (i_rst          ),
        .o_Halt             (o_halt         ),
        .o_ACC              (o_acc          )              
    );
    
    uart_tx
    #(
        .DBIT               (DBIT           ),
        .SB_TICK            (SBTICK         )
    )
    u_uart_tx
    (
        .i_clk              (i_clk          ),
        .i_reset            (rst            ),
        .i_tx_start         (i_start        ),
        .i_s_tick           (i_stick        ),
        .i_din              (i_data         ),
        .o_tx_done          (tx_done        ),
        .o_tx               (o_tx           )
    );
    
    mod_m_counter  
    #(  
        .N                (SIZ      ),
        .M                (DIV      ) 
    )
    u_m_counter  
    (  
        .i_clk              (i_clk      ),
        .i_reset            (rst        ),  
        .o_max_tick         (o_stick    )
    ); 
  
   assign i_stick = o_stick;
    
endmodule
 
