`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 12:34:30
// Design Name: 
// Module Name: tb_adder_subtractor
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


module tb_adder_subtractor();

    localparam NBITS = 16;
    
    reg [NBITS-1:0] ACC     ;
    reg [NBITS-1:0] SelB    ;
    reg             Op      ;
    reg [NBITS-1:0] Result  ;
    
    initial begin
    ACC = NBITS-1'b01;
    SelB = NBITS-1'b01;
    Op = 1'b1;
    #20
    
    ACC = NBITS-1'b01;
    SelB = NBITS-1'b01;
    Op = 1'b0;
    #20
    
    $display("###############test ok###########");
    $finish;
    end
    
    adder_subtractor
    #(
        .NBITS      (NBITS   )
    )
    u_adder_subtractor
    (
        .i_ACC      (ACC    ),
        .i_SelB     (SelB   ),
        .i_Op       (Op     )
        //.o_Result   (Result )
    );
    
endmodule
