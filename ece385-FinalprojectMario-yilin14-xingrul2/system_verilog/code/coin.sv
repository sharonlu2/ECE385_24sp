`timescale 1ns / 1ps

module coins(
    input logic clk,
    input logic [9:0] brick_y1, brick_y2, brick_y3, brick_y4, brick_y5, brick_y6,
    input logic [9:0] coin_x1, coin_x2, coin_x3, coin_x4, coin_x5, coin_x6,
    input logic power_up,
    input logic [9:0] char_y,
    output logic [9:0] coin_y1, coin_y2, coin_y3, coin_y4, coin_y5, coin_y6,
    output logic [7:0] coin_score
);

    localparam CHARACTER_X = 320;
    logic [7:0] coin_score_next;
    logic [5:0] coin_touched;
        logic power_up_prev;  // Flags to indicate if each coin has been touched
//logic [5:0] coin_touched_next;
    // Initialize coin_score and touched flags
//    initial begin
//        coin_score = 0;
//        coin_touched = 6'b000000;  // No coins touched initially
//    end

//always_ff @(posedge power_up) begin
//            coin_touched <= 6'b000000;
//    end


    always_ff @(posedge clk) begin
        if (power_up != power_up_prev) begin
            // Reset touched flags when power_up is newly turned on
            coin_touched <= 6'b000000;
        end else if (power_up) begin
            // Update touched flags based on interactions
            coin_touched[0] <= check_interaction(coin_x1, char_y, coin_y1, coin_touched[0]);
            coin_touched[1] <= check_interaction(coin_x2, char_y, coin_y2, coin_touched[1]);
            coin_touched[2] <= check_interaction(coin_x3, char_y, coin_y3, coin_touched[2]);
            coin_touched[3] <= check_interaction(coin_x4, char_y, coin_y4, coin_touched[3]);
            coin_touched[4] <= check_interaction(coin_x5, char_y, coin_y5, coin_touched[4]);
            coin_touched[5] <= check_interaction(coin_x6, char_y, coin_y6, coin_touched[5]);
        end
        // Update previous power_up state
        power_up_prev <= power_up;
        // Update coin scores
        coin_score <= coin_score_next;
    end


    // Combinational logic to calculate next score and interactions
    always_comb begin
        coin_score_next = coin_score;  // Start with current score
        
        // Handling coin positions and interactions based on touch and power_up
        if (power_up) begin
            // Check each coin for interaction
            // Coin 1
            if (coin_touched[0]) begin
//                coin_touched[0] = 1'b1;
                coin_y1 = 481;
                coin_score_next = coin_score + 1;
            end else begin
                coin_y1 = brick_y1 - 30;
            end

            // Coin 2
            if (coin_touched[1]) begin
//                coin_touched[1] = 1'b1;
                coin_y2 = 481;
                coin_score_next = coin_score + 1;
            end else begin
                coin_y2 = brick_y2 - 30;
            end

            // Coin 3
            if (coin_touched[2]) begin
//                coin_touched[2] = 1'b1;
                coin_y3 = 481;
                coin_score_next = coin_score + 1;
            end else begin
                coin_y3 = brick_y3 - 30;
            end

            // Coin 4
            if (coin_touched[3]) begin
//                coin_touched[3] = 1'b1;
                coin_y4 = 481;
                coin_score_next = coin_score + 1;
            end else begin
                coin_y4 = brick_y4 - 45;
            end

            // Coin 5
            if (coin_touched[4]) begin
//                coin_touched[4] = 1'b1;
                coin_y5 = 481;
                coin_score_next = coin_score + 1;
            end else begin
                coin_y5 = brick_y5 - 30;
            end

            // Coin 6
            if (coin_touched[5]) begin
//                coin_touched[5] = 1'b1;
                coin_y6 = 481;
                coin_score_next = coin_score + 1;
            end else begin
                coin_y6 = brick_y6 - 60;
            end
        end else begin
            // Reset all coin positions when power_up is not active
            coin_y1 = 481; coin_y2 = 481; coin_y3 = 481;
            coin_y4 = 481; coin_y5 = 481; coin_y6 = 481;
//            coin_touched = 6'b000000;  // Reset touched flags
        end
    end
    
   function automatic logic check_interaction(input logic [9:0] coin_x, input logic [9:0] char_y, input logic [9:0] coin_y, input logic touched);
        if (touched || ((CHARACTER_X - coin_x <= 30) && (CHARACTER_X - coin_x >= -30) &&
                        (char_y - coin_y <= 30) && (char_y - coin_y >= -30))) begin
//            coin_score_next = coin_score_next + 1;
            return 1'b1;  // Coin is touched
        end else begin
            return touched;  // Maintain current state if not touched
        end
    endfunction
    // Sequential logic to update the score and coin positions at the clock edge

endmodule
