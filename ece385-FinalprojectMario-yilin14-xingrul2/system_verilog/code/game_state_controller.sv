module Debouncer (
    input logic clk,          
    input logic reset,        
    input logic noisy_signal, 
    output logic clean_signal 
);

    parameter WIDTH = 4;                   
    parameter COUNT_THRESHOLD = 4'hF;     

    // Internal signals
    logic [WIDTH-1:0] counter;             
    logic stable_signal;                  

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            stable_signal <= noisy_signal;
            clean_signal <= noisy_signal;
        end else begin
            if (noisy_signal == stable_signal) begin
                if (counter < COUNT_THRESHOLD) begin
                    counter <= counter + 1;
                end else if (counter == COUNT_THRESHOLD) begin
                    clean_signal <= stable_signal;  
                end
            end else begin
                counter <= 0;                     
                stable_signal <= noisy_signal;    
            end
        end
    end

endmodule


module game_display_controller(
    input logic clk,
    input logic reset,
    input logic [7:0] key_code_raw, 
    input logic [1:0] lives,
    output logic [1:0] state_out    
);

    logic debounced_space;
    logic last_debounced_space;
    logic space_pressed;

    Debouncer debouncer(
        .clk(clk),
        .reset(reset),
        .noisy_signal(key_code_raw == 8'h2C), 
        .clean_signal(debounced_space)       
    );

    enum logic [1:0] {START_SCREEN, GAME_SCREEN, GAME_OVER} state, next_state;

    assign state_out = state;

    always_ff @(posedge clk) begin
        if (reset) begin
            last_debounced_space <= 0;
            space_pressed <= 0;
        end else begin
            space_pressed <= !last_debounced_space && debounced_space; 
            last_debounced_space <= debounced_space;
        end
    end

    always_comb begin
        next_state = state;
        unique case (state)
            START_SCREEN: begin
                if (space_pressed)
                    next_state = GAME_SCREEN;
                else
                    next_state = START_SCREEN;
            end
            GAME_SCREEN: begin
                if (lives == 3)
                    next_state = GAME_OVER;
                else
                    next_state = GAME_SCREEN;
            end
            GAME_OVER: begin
                if (space_pressed)
                    next_state = START_SCREEN;
                else
                    next_state = GAME_OVER;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= START_SCREEN;
        end else begin
            state <= next_state;
        end
    end
endmodule
