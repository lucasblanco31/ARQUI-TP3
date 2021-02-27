`timescale 1ns / 1ps


module tb_full();
    //BIP PARAMETERS
    localparam NBITS_O   =   11;
    localparam NBITS_E   =    5;
    localparam NBITS_D   =   16;
    localparam OPCODE    =    5;
    localparam CELDAS    =   10;
    //UART PARAMETERS
    localparam  DBIT     =    8;
    localparam  SBTICK   =   16;
    localparam  SIZ      =    8;
    localparam  DIV      =    6; //10Mhz -> 115000baudrate 
    
   
    reg         rst_clk; //reset del clock
    reg         rst;    //reset del sistema que tiene que ser despues de que el clk_wzd se estabiliza
    reg         clk;
    wire        locked;
    
    
    reg         [NBITS_D-1 :0]       outData;         
    reg                              count;                      
    
    wire                             i_stick;
    wire                             o_stick; 
    wire                             tx_out;
    wire                             rx_in;
    wire                             rx_done;
    wire        [DBIT-1    :0]       rx_data;
        
    initial begin
      #10
      clk       = 1'b0;
      rst_clk   = 1'b0;
      rst       = 1'b0;
   
      while(locked != 1'b1) begin
        #10
        rst_clk = 1'b1;
      end
      
      #100
      rst_clk = 1'b0;
      rst     = 1'b0;
      
      count     = 1'b0;
      outData   = {NBITS_D{1'b0}};
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
                    if(rx_done)
                    begin
                        count                        =   count   +   1;
                        outData[NBITS_D-DBIT-1: 0]   =   rx_data;   
                    end
                end
            1'b1:
                begin
                    if(rx_done)
                    begin
                        count                       =    1'b0;
                        outData[NBITS_D-1:DBIT]     =    rx_data;
                    end
                end
            default:
                begin
                    outData   = {NBITS_D{1'b0}};
                    count   = 1'b0;
                 end
         endcase
    end
     
    always begin
      #50 
      clk = ~clk;
    end
    
    top
    #(
        .NBITS_O            (NBITS_O        ),
        .NBITS_E            (NBITS_E        ),
        .NBITS_D            (NBITS_D        ),
        .OPCODE             (OPCODE         ),
        .CELDAS             (CELDAS         ),
        .DBIT               (DBIT           ),
        .SBTICK             (SBTICK         ),
        .SIZ                (SIZ            ),
        .DIV                (DIV            )
    )
    u_top
    (
        .i_clk              (clk            ),
        .i_rst              (rst            ),
        .i_rst_clk          (rst_clk        ),
        .o_tx               (tx_out         ),
        .o_locked           (locked         )         
    );
    
    uart_rx
    #(
        .DBIT               (DBIT           ),
        .SB_TICK            (SBTICK         )
    )
    u_uart_rx
    (
        .i_clk              (clk            ),
        .i_reset            (rst            ),
        .i_rx               (rx_in          ),
        .i_s_tick           (i_stick        ),
        .o_rx_done          (rx_done        ),
        .o_rx               (rx_data        )
    );
    
    mod_m_counter
    //m_counter  
    #(  
        .N                  (SIZ            ),
        .M                  (DIV            ) 
    )
    u_m_counter  
    (  
        .i_clk            (clk        ),
        .i_reset          (rst        ),  
        .o_max_tick       (o_stick    )
  ); 
  
   assign i_stick =     o_stick;
   assign rx_in   =     tx_out;
    
endmodule
 
