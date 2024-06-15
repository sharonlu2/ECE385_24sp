`timescale 1ns / 1ps

module reg_writing(
    input logic [7:0] score_num,         
    input logic [1:0] life_num,           
    output logic [31:0] reg_font[7] 
    );
logic [4:0] low_digit_score;
logic [4:0] high_digit_score;

assign low_digit_score = score_num%10;
assign high_digit_score = score_num/10;

always_comb
begin
    case (life_num)
        2'b00: reg_font[6] = 33'h00838383; 
        2'b01: reg_font[6] = 33'h00008383;
        2'b10: reg_font[6] = 33'h00000083; 
        2'b11: reg_font[6] = 33'h00000000;
        default: reg_font[6] = 33'h00000000; 
    endcase
end

assign reg_font[0][31:24] = 8'h72;
assign reg_font[0][23:16] = 8'h6f;
assign reg_font[0][15:8] = 8'h63;
assign reg_font[0][7:0] = 8'h53;

assign reg_font[1][31:24] = 8'h00;
assign reg_font[1][23:16] = 8'h00;
assign reg_font[1][15:8] = 8'h7c;
assign reg_font[1][7:0] = 8'h65;

assign reg_font[2][31:28] = 4'h3;
assign reg_font[2][27:24] =  low_digit_score;
assign reg_font[2][23:20] = 4'h3;
assign reg_font[2][19:16] = high_digit_score;
assign reg_font[2][15:8] = 8'h00;
assign reg_font[2][7:0] = 8'h00;

assign reg_font[3][31:24] = 8'h00;
assign reg_font[3][23:16] = 8'h00;
assign reg_font[3][15:8] = 8'h00;
assign reg_font[3][7:0] = 8'h00;

assign reg_font[4][31:24] = 8'h45;
assign reg_font[4][23:16] = 8'h46;
assign reg_font[4][15:8] = 8'h49;
assign reg_font[4][7:0] = 8'h4c;

assign reg_font[5][31:24] = 8'h00;
assign reg_font[5][23:16] = 8'h00;
assign reg_font[5][15:8] = 8'h00;
assign reg_font[5][7:0] = 8'h7c;
endmodule
