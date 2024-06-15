`timescale 1ns / 1ps

module monsters(
    input logic frame_clk,         
    input logic [9:0] char_y,     
    input logic max_page,          
    input logic [7:0] page_index,  
    input logic [1:0] game_state,
    output logic [9:0] monster_x,  
    output logic [1:0] life,       
    output logic [7:0] score,     
    output logic power_up          
);

    localparam CHARACTER_X = 320;
    localparam MONSTER_START_X = 641;
    localparam MONSTER_Y = 344;
    localparam TOUCH_THRESHOLD = 30;

    logic [9:0] internal_monster_x = MONSTER_START_X;
    logic move_enable;
    logic [7:0] last_page_index = 0; 
    logic [9:0] power_up_counter = 0;  

    always_ff @(posedge frame_clk) begin
        if (last_page_index != page_index && max_page) begin
            move_enable <= 1;  
            internal_monster_x <= MONSTER_START_X;
        end
        last_page_index <= page_index; 

        if (move_enable) begin
            if (internal_monster_x > 0) begin
                internal_monster_x <= internal_monster_x - 3;
            end else begin
                move_enable <= 0;  
                internal_monster_x <= MONSTER_START_X;
            end
        end

               if ((MONSTER_Y - char_y <= TOUCH_THRESHOLD)&(((CHARACTER_X - internal_monster_x == 28)|(internal_monster_x - CHARACTER_X == 28))|((CHARACTER_X - internal_monster_x == TOUCH_THRESHOLD)|(internal_monster_x - CHARACTER_X == TOUCH_THRESHOLD))|((CHARACTER_X - internal_monster_x == 29)|(internal_monster_x - CHARACTER_X == 29)))) begin
            life <= life + 1;
            internal_monster_x <= MONSTER_START_X; 
            move_enable <= 0; 
        end

        if (((MONSTER_Y - char_y == TOUCH_THRESHOLD)|(MONSTER_Y - char_y == 29)|(MONSTER_Y - char_y == 28))&((CHARACTER_X - internal_monster_x <= TOUCH_THRESHOLD)|(internal_monster_x - CHARACTER_X <= TOUCH_THRESHOLD))) begin
            score <= score + 5;
            power_up <= 1;
            power_up_counter <= 1000; 
            internal_monster_x <= MONSTER_START_X;
            move_enable <= 0;
            if (life != 0) life <= life - 1;
        end

        if (power_up_counter > 0) begin
            power_up_counter <= power_up_counter - 1; 
            if (power_up_counter == 1) begin  
                power_up <= 0;
            end
        end
        if (game_state == 2'b10)begin
            life <= 0;
            score <= 0;
            end
    end

    assign monster_x = internal_monster_x;

endmodule