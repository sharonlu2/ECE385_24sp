//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper (
input logic scored,
input logic [9:0] x_monster,
input logic max_page,
input logic frame_clk,
input logic divided_clk,
input  logic [7:0]  keycode,
input logic [9:0] block_y_1,
input logic [9:0] block_y_2, 
input logic [9:0] block_y_3, 
input logic [9:0] block_y_4, 
input logic [9:0] block_y_5, 
input logic [9:0] block_y_6, 
input logic [9:0] block_y_7, 
input logic [9:0] block_y_8,
input logic [4:0] block_question,
input logic [1:0] game_state,
//input logic  block_question_1,
//input logic  block_question_2, 
//input logic  block_question_3, 
//input logic  block_question_4, 
//input logic  block_question_5, 
//input logic  block_question_6, 
//input logic  block_question_7, 
//input logic  block_question_8, 
input logic [9:0] coin_x1, coin_x2, coin_x3, coin_x4,
                      coin_x5, coin_x6,
input logic [9:0] coin_y1, coin_y2, coin_y3, coin_y4,
                       coin_y5, coin_y6,
input logic Clk,
input  logic [9:0] mario_y, 
input [9:0] BallX_offset,
input logic reset,
//input  logic [9:0] luigi_x,  luigi_y, 
input  logic [9:0] DrawX, DrawY,
output logic [3:0]  Red, Green, Blue );
    logic ball_on;
    logic [4:0] block_on;
    int DistX, DistY;
    assign DistX = DrawX - 320;
    assign DistY = DrawY - mario_y;
    int block1_DistX, block1_DistY;
    int block2_DistX, block2_DistY;
    int block3_DistX, block3_DistY;
    int block4_DistX, block4_DistY;
    int block5_DistX, block5_DistY;
    int block6_DistX, block6_DistY;
    int block7_DistX, block7_DistY;
    int block8_DistX, block8_DistY;
    int coin1_DistX, coin1_DistY;
    int coin2_DistX, coin2_DistY;
    int coin3_DistX, coin3_DistY;
    int coin4_DistX, coin4_DistY;
    int coin5_DistX, coin5_DistY;
    int coin6_DistX, coin6_DistY;    
    
    assign block1_DistX = DrawX - (640 - BallX_offset);
    assign block1_DistY = DrawY - block_y_1;
        assign block2_DistX = DrawX - (640 - BallX_offset) -28;
    assign block2_DistY = DrawY - block_y_2;
        assign block3_DistX = DrawX - (640 - BallX_offset)-28*2;
    assign block3_DistY = DrawY - block_y_3;
        assign block4_DistX = DrawX - (640 - BallX_offset)-28*3;
    assign block4_DistY = DrawY - block_y_4;
        assign block5_DistX = DrawX - (640 - BallX_offset)-28*5;
    assign block5_DistY = DrawY - block_y_5;
        assign block6_DistX = DrawX - (640 - BallX_offset)-28*6;
    assign block6_DistY = DrawY - block_y_6;
        assign block7_DistX = DrawX - (640 - BallX_offset)-28*7;
    assign block7_DistY = DrawY - block_y_7;
            assign block8_DistX = DrawX - (640 - BallX_offset)-28*8;
    assign block8_DistY = DrawY - block_y_8;
    
    assign coin1_DistX = DrawX - coin_x1;
assign coin1_DistY = DrawY - coin_y1;

assign coin2_DistX = DrawX - coin_x2;
assign coin2_DistY = DrawY - coin_y2;

assign coin3_DistX = DrawX - coin_x3;
assign coin3_DistY = DrawY - coin_y3;

assign coin4_DistX = DrawX - coin_x4;
assign coin4_DistY = DrawY - coin_y4;

assign coin5_DistX = DrawX - coin_x5;
assign coin5_DistY = DrawY - coin_y5;

assign coin6_DistX = DrawX - coin_x6;
assign coin6_DistY = DrawY - coin_y6;
    
 logic [9:0] active_coin_DistX, active_coin_DistY;
 
    logic [9:0] mario_address_next;
    logic [9:0] mario_address;
    logic [9:0] left_address;
    logic [9:0] right_address;
    logic [1:0] mario_palette_data;
    logic [1:0] stand_palette_data;
    logic [9:0] monster_address;
    logic [1:0] monster_palette_data;
    logic  run;
    logic run_next;
    logic  right;
    logic right_next;
    logic [1:0] run_palette_data;
    logic [17:0] bgup_address;
    logic [1:0] bgup_palette_data;
    logic [17:0] bgdown_address;
    logic [1:0] bgdown_palette_data;
    logic question_palette_data;
    logic [1:0]starttext_palette_data;
    logic [1:0]startpic_palette_data;
    logic [1:0] coin_palette_data;

    logic [9:0] brick_address;
    logic [9:0] brick_address_1;
    logic [9:0] brick_address_2;
    logic [9:0] brick_address_3;
    logic [9:0] brick_address_4;
    logic [9:0] brick_address_5;
    logic [9:0] brick_address_6;
    logic [9:0] brick_address_7;
    logic [9:0] brick_address_8;
    logic [14:0] gameover_address;
    logic [14:0] startpic_address;
    logic [13:0] starttext_address;
    logic brick_palette_data;
//    logic [8:0] mario_address1;
//    logic [2:0] mario_palette_data1;
    logic [3:0] mario_red;    
    logic [3:0] mario_green;
    logic [3:0] mario_blue;
    logic [3:0] bgup_red;    
    logic [3:0] bgup_green;
    logic [3:0] bgup_blue;
    logic [3:0] bgdown_red;    
    logic [3:0] bgdown_green;
    logic [3:0] bgdown_blue;
    logic [3:0] brick_red;    
    logic [3:0] brick_green;
    logic [3:0] brick_blue;
        logic [3:0] block_red;    
    logic [3:0] block_green;
    logic [3:0] block_blue;
    logic [3:0] question_red;    
    logic [3:0] question_green;
    logic [3:0] question_blue; 
    logic [3:0] monster_red;    
    logic [3:0] monster_green;
    logic [3:0] monster_blue;
    logic [3:0] gameover_red;    
    logic [3:0] gameover_green;
    logic [3:0] gameover_blue;  
    logic [3:0] start_text_red;    
    logic [3:0] start_text_green;
    logic [3:0] start_text_blue;
    logic [3:0] start_pic_red;    
    logic [3:0] start_pic_green;
    logic [3:0] start_pic_blue; 
    logic [3:0] coin_red;    
    logic [3:0] coin_green;
    logic [3:0] coin_blue;     
    logic [9:0] DrawX_real;
    logic gameover_on;
//    logic start_on;
    logic start_pic_on;
    logic start_text_on;    
     // Constants for the Game Over image position and size
    localparam integer GAME_OVER_X_START = 219;
    localparam integer GAME_OVER_X_END = 419; // 120 + 200 - 1
    localparam integer GAME_OVER_Y_START = 189;
    localparam integer GAME_OVER_Y_END = 289; // 190 + 100 - 1
    localparam integer START_X_START = 219;
    localparam integer START_X_END = 419; // 120 + 200 - 1
    localparam integer START_X_END_PIC = 459; // 120 + 200 - 1
    localparam integer START_PIC_Y_START = 149;
    localparam integer START_PIC_Y_END = 269; // 190 + 100 - 1
    localparam integer START_TEXT_Y_START = 279;
    localparam integer START_TEXT_Y_END = 359; // 190 + 100 - 1   
        
    always_comb
    begin 
    if (DrawX < 640 - BallX_offset)
    DrawX_real = DrawX + BallX_offset;
    else
    DrawX_real =  BallX_offset - (640 - DrawX);
    end
    assign  right_address = DistX+ DistY*30;
    assign  left_address = (30-DistX)+ DistY*30;
    assign bgup_address = DrawX_real + DrawY*640;
    assign bgdown_address = DrawX_real + (DrawY-240)*640;
    assign brick_address_1 = block1_DistX + block1_DistY*28;
    assign brick_address_2 = block1_DistX + block1_DistY*28;
    assign brick_address_3 = block1_DistX + block1_DistY*28;
    assign brick_address_4 = block1_DistX + block1_DistY*28;
    assign brick_address_5 = block1_DistX + block1_DistY*28;
    assign brick_address_6 = block1_DistX + block1_DistY*28;
    assign brick_address_7 = block1_DistX + block1_DistY*28;
    assign brick_address_8 = block1_DistX + block1_DistY*28;
    logic [9:0] monster_disx;
    assign monster_disx = DrawX - x_monster;
    assign monster_address = monster_disx + (DrawY - 344)*30;
    logic [3:0] coin_on;
    assign starttext_address = (DrawX - START_X_START - 20) + (DrawY - START_TEXT_Y_START )* 200;
    assign startpic_address = (DrawX - START_X_START) + (DrawY - START_PIC_Y_START )* 240;
    assign gameover_address = (DrawX - GAME_OVER_X_START) + (DrawY - GAME_OVER_Y_START )* 200;
    
    logic monster_on;
//    assign monster_on = (monster_disx >= 0)&(monster_disx <30) &(DrawY > 450)& monster_display;
    assign monster_on = (monster_disx >= 0)&(monster_disx <30)&(DrawY >= 344)&(DrawY < 374);
    always_comb
    begin
    if ((block_question == block_on)&(~scored)&max_page)
    begin
    block_red = question_red;
    block_green =  question_green;
    block_blue =  question_blue;
    end
    else
    begin
    block_red = brick_red;
    block_green = brick_green;
    block_blue = brick_blue;
    end
    end

    logic [9:0] coin_address;
    assign coin_address = active_coin_DistX + active_coin_DistY*30;
    always_comb begin
    unique case (coin_on)
        4'b0001: begin
            active_coin_DistX = coin1_DistX;
            active_coin_DistY = coin1_DistY;
        end
        4'b0010: begin
            active_coin_DistX = coin2_DistX;
            active_coin_DistY = coin2_DistY;
        end
        4'b0011: begin
            active_coin_DistX = coin3_DistX;
            active_coin_DistY = coin3_DistY;
        end
        4'b0100: begin
            active_coin_DistX = coin4_DistX;
            active_coin_DistY = coin4_DistY;
        end
        4'b0101: begin
            active_coin_DistX = coin5_DistX;
            active_coin_DistY = coin5_DistY;
        end
        4'b0110: begin
            active_coin_DistX = coin6_DistX;
            active_coin_DistY = coin6_DistY;
        end
        default: begin
            active_coin_DistX = 10'd0;  // Default or reset state
            active_coin_DistY = 10'd0;
        end
    endcase
end 
       
      pic1 maincharacter(
        .data_In(2'b0),
        .write_address(10'b0),
		.read_address(mario_address),
		.we(1'b0), 
		.Clk(Clk),
		.data_Out(run_palette_data)
    );
    
    mario_stand mario_stand_inst(
            .data_In(2'b0),
        .write_address(10'b0),
		.read_address(mario_address),
		.we(1'b0), 
		.Clk(Clk),
		.data_Out(stand_palette_data)
    );
    
    coin_1 coin_1_inst(
        .data_In(2'b0),
        .write_address(10'b0),
		.read_address(coin_address),
		.we(1'b0), 
		.Clk(Clk),
		.data_Out(coin_palette_data)
    );    
        monster_pic monster_pic_inst(
        .data_In(2'b0),
        .write_address(10'b0),
		.read_address(monster_address),
		.we(1'b0), 
		.Clk(Clk),
		.data_Out(monster_palette_data)
    );
        start_pic start_pic_inst(
        .data_In(2'b0),
        .write_address(10'b0),
		.read_address(startpic_address),
		.we(1'b0), 
		.Clk(Clk),
		.data_Out(startpic_palette_data)
    );
        start_text start_text_inst(
        .data_In(2'b0),
        .write_address(10'b0),
		.read_address(starttext_address),
		.we(1'b0), 
		.Clk(Clk),
		.data_Out(starttext_palette_data)
    );

        gameover gameover_inst(
        .data_In(2'b0),
        .write_address(10'b0),
		.read_address(gameover_address),
		.we(1'b0), 
		.Clk(Clk),
		.data_Out(gameover_palette_data)
    );
//          bg1 bgup(
//        .data_In(2'b0),
//        .write_address(18'b0),
//		.read_address(bgup_address),
//		.we(1'b0), 
//		.Clk(Clk),
//		.data_Out(bgup_palette_data)
//    );
    
//          bg2 bgdown(
//        .data_In(2'b0),
//        .write_address(18'b0),
//		.read_address(bgdown_address),
//		.we(1'b0), 
//		.Clk(Clk),
//		.data_Out(bgdown_palette_data)
//    );
    
//         brick brick_inst(
//        .data_In(1'b0),
//        .write_address(10'b0),
//		.read_address(brick_address),
//		.we(1'b0), 
//		.Clk(Clk),
//		.data_Out(brick_palette_data)
//    );
    
//        question question_inst(
//        .data_In(1'b0),
//        .write_address(10'b0),
//		.read_address(brick_address),
//		.we(1'b0), 
//		.Clk(Clk),
//		.data_Out(question_palette_data)
//    );
    
    
    
    mario_palette mario_palette_inst(
        .palette_index(mario_palette_data),
        .red(mario_red), 
        .green(mario_green), 
        .blue(mario_blue)
    );
   
     coin_palette coin_palette_inst(
         .palette_index(coin_palette_data),
        .red(coin_red), 
        .green(coin_green), 
        .blue(coin_blue));
           
//        bgup_palette bgup_palette_inst(
//        .palette_index(bgup_palette_data),
//        .red(bgup_red), 
//        .green(bgup_green), 
//        .blue(bgup_blue)
//    );

    bgdown_palette bgdown_palette_inst(
        .palette_index(bgdown_palette_data),
        .red(bgdown_red), 
        .green(bgdown_green), 
        .blue(bgdown_blue)
    );
    
   brick_palette brick_palette_inst(
        .palette_index(brick_palette_data),
        .red(brick_red), 
        .green(brick_green), 
        .blue(brick_green)
    );
    
       question_palette question_palette_inst(
        .palette_index(question_palette_data),
        .red(question_red), 
        .green(question_green), 
        .blue(question_green)
    );
    
    monster_palette monster_palette_inst(
        .palette_index(monster_palette_data),
        .red(monster_red), 
        .green(monster_green), 
        .blue(monster_blue)
    );
 
     gameover_palette  gameover_palette_inst(
        .palette_index(gameover_palette_data),
        .red(gameover_red), 
        .green(gameover_green), 
        .blue(gameover_blue)
    );

     startpic_palette  startpic_palette_inst(
        .palette_index(startpic_palette_data),
        .red(start_pic_red), 
        .green(start_pic_green), 
        .blue(start_pic_blue)
    );

     starttext_palette  starttext_palette_inst(
        .palette_index(starttext_palette_data),
        .red(start_text_red), 
        .green(start_text_green), 
        .blue(start_text_blue)
    );
    
    always_comb
    begin
    if(right)
    mario_address = right_address;
    else
    mario_address = left_address;
    end
    
   
   always_comb
   begin
   if(run)
   begin
   if(divided_clk)
   begin
mario_palette_data = run_palette_data;
end 
else
mario_palette_data = stand_palette_data;
end
   else
mario_palette_data = stand_palette_data;
   end
   
   always_comb
   begin
   if((keycode == 8'h04)||(keycode == 8'h07))
   run_next = 1;
   else
   run_next = 0;
   end
   
   
   always_comb
   begin
   if((keycode == 8'h04))
   begin
//   right_next = 0;
   right_next = 0;
   end
   else if (keycode == 8'h07)
   begin
   right_next = 1;
   end
   else
   right_next = right;
   end
   
   always_ff @(posedge frame_clk)
   begin
   run <= run_next;
   right <= right_next;
   end
    
    always_comb
    begin
    case (block_on)
        4'b1000: brick_address = brick_address_1; // Case 0: Output is set to hexadecimal FF
        4'b1001: brick_address = brick_address_2; // Case 1: Output is set to hexadecimal 80
        4'b1010: brick_address = brick_address_3; // Case 2: Output is set to hexadecimal 40
        4'b1011: brick_address = brick_address_4; // Case 3: Output is set to hexadecimal 20
        4'b1100: brick_address = brick_address_5; // Case 4: Output is set to hexadecimal 10
        4'b1101: brick_address = brick_address_6; // Case 5: Output is set to hexadecimal 08
        4'b1110: brick_address = brick_address_7; // Case 6: Output is set to hexadecimal 04
        4'b1111: brick_address = brick_address_8; // Case 7: Output is set to hexadecimal 01
        default: brick_address = 10'b0; // Default case: Output is set to 0
    endcase
    end
    
    // Combinational logic to determine if we should draw a Game Over pixel
    always_comb 
    begin:Game_over_on
        // Check if we are within the Game Over image bounds and the Game Over screen is active
        if ((DrawX >= GAME_OVER_X_START) && (DrawX < GAME_OVER_X_END) &&
            (DrawY >= GAME_OVER_Y_START) && (DrawY < GAME_OVER_Y_END)) begin
            gameover_on = 1'b1;
        end else begin
            gameover_on = 1'b0;
        end
    end

    always_comb 
    begin:START_ON
        // Check if we are within the Game Over image bounds and the Game Over screen is active
        if ((DrawX >= START_X_START) && (DrawX < START_X_END_PIC) &&
            (DrawY >= START_PIC_Y_START) && (DrawY < START_PIC_Y_END)) begin
            start_pic_on = 1'b1;
            start_text_on = 1'b0;
        end else if ((DrawX >= START_X_START + 20) && (DrawX < START_X_END + 20) &&
            (DrawY >= START_TEXT_Y_START) && (DrawY < START_TEXT_Y_END))begin
            start_text_on = 1'b1;
            start_pic_on = 1'b0;
        end
        else begin
            start_text_on = 1'b0;
            start_pic_on = 1'b0;            
        end
    end
    
    always_comb
    begin:Ball_on_proc
        if ((DistX>=0)&&(DistX<30)&&(DistY>=0)&&(DistY<30))
        begin
            ball_on = 1'b1;
            block_on = 4'b0000;
            coin_on = 4'b0000;
            
            end
        else if ((block1_DistX >=0)&&(block1_DistX<28)&&(block1_DistY>=0)&&(block1_DistY<28))
        begin
            ball_on = 1'b0;
            block_on = 4'b1000;
            coin_on = 4'b0000;

            end
         else if ((block2_DistX >=0)&&(block2_DistX<28)&&(block2_DistY>=0)&&(block2_DistY<28))
        begin
            ball_on = 1'b0;
            block_on = 4'b1001;
            coin_on = 4'b0000;

            end 
         else if ((block3_DistX >=0)&&(block3_DistX<28)&&(block3_DistY>=0)&&(block3_DistY<28))
        begin
            ball_on = 1'b0;
            block_on = 4'b1010;
            coin_on = 4'b0000;

            end 
         else if ((block4_DistX >=0)&&(block4_DistX<28)&&(block4_DistY>=0)&&(block4_DistY<28))
        begin
            ball_on = 1'b0;
            block_on = 4'b1011;
            coin_on = 4'b0000;

            end 
         else if ((block5_DistX >=0)&&(block5_DistX<28)&&(block5_DistY>=0)&&(block5_DistY<28))
        begin
            ball_on = 1'b0;
            block_on = 4'b1100;
            coin_on = 4'b0000;

            end 
         else if ((block6_DistX >=0)&&(block6_DistX<28)&&(block6_DistY>=0)&&(block6_DistY<28))
        begin
            ball_on = 1'b0;
            block_on = 4'b1101;
            coin_on = 4'b0000;

            end 
         else if ((block7_DistX >=0)&&(block7_DistX<28)&&(block7_DistY>=0)&&(block7_DistY<28))
        begin
            ball_on = 1'b0;
            block_on = 4'b1110;
            coin_on = 4'b0000;

            end 
         else if ((block8_DistX >=0)&&(block8_DistX<28)&&(block8_DistY>=0)&&(block8_DistY<28))
        begin
            ball_on = 1'b0;
            block_on = 4'b1111;
            coin_on = 4'b0000;
            end 
        else if ((coin1_DistX >= 0) && (coin1_DistX < 30) && (coin1_DistY >= 0) && (coin1_DistY < 30))
    begin
        ball_on = 1'b0;
        block_on = 4'b0000;
        coin_on = 4'b0001;;  // Using 'coin_on' with updated binary encoding
    end
    else if ((coin2_DistX >= 0) && (coin2_DistX < 30) && (coin2_DistY >= 0) && (coin2_DistY < 30))
    begin
        ball_on = 1'b0;
        block_on = 4'b0000;
        coin_on = 4'b0010;
    end 
    else if ((coin3_DistX >= 0) && (coin3_DistX < 30) && (coin3_DistY >= 0) && (coin3_DistY < 30))
    begin
        ball_on = 1'b0;
        block_on = 4'b0000;
        coin_on = 4'b0011;
    end 
    else if ((coin4_DistX >= 0) && (coin4_DistX < 30) && (coin4_DistY >= 0) && (coin4_DistY < 30))
    begin
        ball_on = 1'b0;
        block_on = 4'b0000;
        coin_on = 4'b0100;
    end 
    else if ((coin5_DistX >= 0) && (coin5_DistX < 30) && (coin5_DistY >= 0) && (coin5_DistY < 30))
    begin
        ball_on = 1'b0;
        block_on = 4'b0000;
        coin_on = 4'b0101;
    end 
    else if ((coin6_DistX >= 0) && (coin6_DistX < 30) && (coin6_DistY >= 0) && (coin6_DistY < 30))
    begin
        ball_on = 1'b0;
        block_on = 4'b0000;
        coin_on = 4'b0110;
    end            
            else
        begin
            ball_on = 1'b0;
            block_on = 4'b0000;
            coin_on = 4'b0000;

        end
     end 

       
    always_comb
    begin:RGB_Display
        unique case(game_state)
        2'b00:
            if (start_text_on == 1) begin
                Red = start_text_red;
                Green = start_text_green;
                Blue = start_text_blue;
            end
           else if (start_pic_on == 1)begin
                Red = start_pic_red; 
                Green = start_pic_green;
                Blue = start_pic_blue;          
           end   
           else begin
                Red = 4'h6; 
                Green = 4'ha;
                Blue = 4'hd;                
           end     
        2'b01:
    if(coin_on != 0)begin
    if(coin_red == 4'hf)
    begin
    if (DrawY < 240)  
        begin
//            Red = bgup_red; 
//            Green = bgup_blue;
//            Blue = bgup_green;
            Red = 4'h6; 
            Green = 4'ha;
            Blue = 4'hd;
            end   
        else begin 
            Red = bgdown_red; 
            Green = bgdown_green;
            Blue = bgdown_blue;
        end
            end
        else
        begin
            Red = coin_red; 
            Green = coin_green;
            Blue = coin_blue;
        end
        end
        else if (monster_on == 1'b1) begin
        if (monster_red == 4'ha)
        begin
                if (DrawY < 240)  
        begin
//            Red = bgup_red; 
//            Green = bgup_blue;
//            Blue = bgup_green;
            Red = 4'h6; 
            Green = 4'ha;
            Blue = 4'hd;
            end   
        else begin 
            Red = bgdown_red; 
            Green = bgdown_green;
            Blue = bgdown_blue;
        end
            end
        else
        begin
            Red = monster_red; 
            Green = monster_green;
            Blue = monster_blue;
        end
        end
        else
        begin
        if (ball_on == 1'b1) begin
            if (mario_red == 4'h0)
            begin
                if (DrawY < 240)  
        begin
//            Red = bgup_red; 
//            Green = bgup_blue;
//            Blue = bgup_green;
            Red = 4'h6; 
            Green = 4'ha;
            Blue = 4'hd;
            end   
        else begin 
            Red = bgdown_red; 
            Green = bgdown_green;
            Blue = bgdown_blue;
        end
            end
            else
            begin
            Red = mario_red;
            Green = mario_green;
            Blue = mario_blue;
            end
        end
        else if(block_on != 0) begin
            Red = block_red;
            Green = block_green;
            Blue = block_blue;
        end
                else if (DrawY < 240)  
        begin
//            Red = bgup_red; 
//            Green = bgup_blue;
//            Blue = bgup_green;
            Red = 4'h6; 
            Green = 4'ha;
            Blue = 4'hd;
            end   
        else begin 
            Red = bgdown_red; 
            Green = bgdown_green;
            Blue = bgdown_blue;
        end 
        end     
        2'b10:
            if (gameover_on == 0) begin
                Red = 4'h0; 
                Green = 4'h0;
                Blue = 4'h0;
            end
           else begin
                Red = gameover_red; 
                Green = gameover_green;
                Blue = gameover_blue;           
           end
                
        endcase

    end 
    
endmodule
