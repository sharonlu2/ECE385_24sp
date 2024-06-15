module score_keeping (
    input logic reset,
    input logic clk,  
    input logic [7:0] blockflags,
    input logic [3:0] block_question, 
    input logic [1:0] game_state,       
    output logic [7:0] score_number,
    output logic scored,
    input logic max_page,
    output logic make_sound
);

    logic [7:0] brick_convert;
    logic [7:0] score_next;
    logic scored_last;
    logic [6:0] sound_timer, sound_timer_next;  
    assign scored = ((blockflags & brick_convert) != 0);

    always_comb begin
        score_next = score_number;
        sound_timer_next = sound_timer;  

        if (scored && !scored_last) begin  
            score_next = score_number + 1;
            sound_timer_next = 40; 
        end
        if (sound_timer > 0) begin
            sound_timer_next = sound_timer - 1; 
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            score_number <= 0;
            scored_last <= 0;
            sound_timer <= 0;
            make_sound <= 0;
        end 
        else begin
            score_number <= score_next;
            scored_last <= scored;  
            sound_timer <= sound_timer_next;

            if (game_state == 2'b10) begin 
                score_number <= 0;  
                sound_timer <= 0; 
            end
            make_sound <= (sound_timer > 0);
        end
    end

    always_comb begin
        unique case(block_question) 
            4'b1000: brick_convert = 8'b00000001;
            4'b1001: brick_convert = 8'b00000010;
            4'b1010: brick_convert = 8'b00000100;
            4'b1011: brick_convert = 8'b00001000;
            4'b1100: brick_convert = 8'b00010000;
            4'b1101: brick_convert = 8'b00100000;
            4'b1110: brick_convert = 8'b01000000;
            4'b1111: brick_convert = 8'b10000000;
            default: brick_convert = 8'b00000000;  
        endcase 
    end

endmodule
