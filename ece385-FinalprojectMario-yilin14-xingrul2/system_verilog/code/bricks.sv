`timescale 1ns / 1ps


module  bricks 
( 
    input  logic        reset, 
    input  logic        frame_clk,
    input int page_index,
    output logic [9:0]  block_y_1,
    output logic [9:0] block_y_2, 
    output logic [9:0] block_y_3, 
    output logic [9:0] block_y_4, 
    output logic [9:0] block_y_5, 
    output logic [9:0] block_y_6, 
    output logic [9:0] block_y_7, 
    output logic [9:0] block_y_8,
    output logic [4:0] block_question
);
always_comb
begin
if (page_index == 1)
begin
block_y_1 = 260;
block_y_2 = 260;
block_y_3 = 260;
block_y_4 = 260;
block_y_5 = 210;
block_y_6 = 210;
block_y_7 = 210;
block_y_8 = 210;
block_question = 4'b1000;
end
else if (page_index == 2)
begin
block_y_1 = 210;
block_y_2 = 210;
block_y_3 = 210;
block_y_4 = 210;
block_y_5 = 260;
block_y_6 = 260;
block_y_7 = 260;
block_y_8 = 260;
block_question = 4'b1001;


end
else if (page_index == 3)
begin
block_y_1 = 210;
block_y_2 = 210;
block_y_3 = 210;
block_y_4 = 210;
block_y_5 = 210;
block_y_6 = 210;
block_y_7 = 210;
block_y_8 = 210;
block_question = 4'b1010;


end
else
begin
block_y_1 = 260;
block_y_2 = 260;
block_y_3 = 260;
block_y_4 = 260;
block_y_5 = 260;
block_y_6 = 260;
block_y_7 = 260;
block_y_8 = 260;
block_question = 4'b1011;


end
end
      
endmodule
