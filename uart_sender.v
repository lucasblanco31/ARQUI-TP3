`timescale 1ns / 1ps

module uart_tx
    #(
    parameter   DBIT        =   8 , // # data b i t s
    parameter   SB_TICK      =  16  // # t i c k s f o r stop bits

    )
    (
    input   wire                    i_clk,
    input   wire                    i_reset,
    input   wire                    i_tx_start,
    input   wire                    i_s_tick,
    input   wire    [DBIT-1:0]      i_din,
    output  reg                     o_tx_done,
    output  wire                    o_tx
    );

// symbolic state
    localparam [1:0]
        idle    = 2'b00,
        start   = 2'b01,
        data    = 2'b10,
        stop    = 2'b11;
        
// signal  declaration
    reg     [1:0]      state_reg;     
    reg     [1:0]      state_next;
    reg     [3:0]      s_reg;
    reg     [3:0]      s_next;
    reg     [2:0]      n_reg;
    reg     [2:0]      n_next;
    reg     [7:0]      b_reg;
    reg     [7:0]      b_next;
    reg                tx_reg;
    reg                tx_next;
    reg                tx_done_next;
    
// body
// FSMD state & data registers
    always @(posedge i_clk , posedge i_reset)
        if (i_reset)
            begin
                state_reg   <=  idle;
                s_reg       <=  0;
                n_reg       <=  0;
                b_reg       <=  0 ;
                tx_reg      <=  1'b1;
                o_tx_done   <=  1'b0;
            end
        else
            begin
                state_reg   <=  state_next;
                s_reg       <=  s_next;
                n_reg       <=  n_next;
                b_reg       <=  b_next;
                tx_reg      <=  tx_next;
                o_tx_done   <=  tx_done_next;
        end
// FSMD next_state  logic & functional units
    always @*
    begin
        state_next      =   state_reg;
        tx_done_next    =   o_tx_done;
        s_next          =   s_reg;
        n_next          =   n_reg;
        b_next          =   b_reg;
        tx_next         =   tx_reg;
        case (state_reg)
            idle:
                begin
                    tx_next = 1'b1;
                    tx_done_next   =  1'b0;
                    if(i_tx_start)
                        begin
                            state_next  =   start;
                            s_next      =   0;
                            b_next      =   i_din;
                        end
                    end
            start:
                begin
                    tx_next = 1'b0;
                    if(i_s_tick)
                        if(s_reg == 15)
                        begin
                            state_next  =   data;  
                            s_next      =   0;
                            n_next      =   0;
                        end
                    else
                        s_next  =   s_reg + 1 ;
                end
            data:
                begin
                    tx_next =   b_reg[0];
                    if(i_s_tick)
                        if(s_reg  ==  15)
                            begin
                                s_next      =   0;
                                b_next      =   b_reg >> 1;
                                if(n_reg == (DBIT-1))
                                    state_next      =   stop;
                                else
                                    n_next          =   n_reg + 1;
                             end
                        else
                            s_next  =   s_reg + 1;
                end
            stop:
                begin
                    tx_next =   1'b1;
                    if(i_s_tick)
                        if(s_reg==(SB_TICK - 1 ))
                        begin
                            state_next      =   idle;
                            tx_done_next  =   1'b1;
                        end
                    else
                        s_next  =   s_reg + 1;
                 end
        endcase
    end
    //output
    assign o_tx = tx_reg;
endmodule
