`timescale 1ns / 1ps


module tb_full();
    //BIP PARAMETERS
    localparam NBITS_O   =   11;
    localparam NBITS_E   =    5;
    localparam NBITS_D   =   16;
    localparam OPCODE    =    5;
    localparam CELDAS    =   10;
    //UART PARAMETERS
    localparam  DBIT        =          8;
    localparam  SBTICK      =          16;
    localparam  SIZ        =           8;
    localparam  DIV         =          6; //10Mhz -> 115000baudrate 
    
    wire                            o_halt;
    wire        [NBITS_D-1  :0]     o_acc;
    
    reg         rst;
    reg         clk;
    
    reg                              i_start;
    wire                             i_stick;
    wire                             o_stick; 
    reg         [DBIT-1 :0]          i_data;
    reg         [1      :0]          count;
    reg         [NBITS_D:0]          acc;
    wire                             tx_done;
       
    
    initial begin
      clk       = 1'b0;
      rst       = 1'b1;
      i_start   = 1'b0;
      i_data    = {DBIT-1{1'b0}};
      count     = 1'b0;
      #100
      rst       = 1'b0;
      #200000
      $finish();         
    end
    
    always @(posedge clk)
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
     
    always begin
      #50 
      clk = ~clk;
    end
    
    
    BIP
    #(
        .NBITS_O            (NBITS_O        ),
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
    
    uart_tx
    #(
      .DBIT             (DBIT      ),
      .SB_TICK          (SBTICK     )
    )
    u_uart_tx
    (
      .i_clk             (clk        ),
      .i_reset           (rst        ),
      .i_tx_start        (i_start    ),
      .i_s_tick          (i_stick    ),
      .i_din             (i_data     ),
      .o_tx_done         (tx_done    )
    );
    
    mod_m_counter  
    #(  
        .N                (SIZ      ),
        .M                (DIV      ) 
    )
    u_m_counter  
    (  
        .i_clk              (clk        ),
        .i_reset            (rst        ),  
        .o_max_tick         (o_stick    )
  ); 
  
   assign i_stick = o_stick;
    
endmodule
 
