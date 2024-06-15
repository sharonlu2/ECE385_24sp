`timescale 1ns / 1ps

module play_notes (
    input logic clk,
    input logic reset,
    input logic start,  
//    input logic [1:0] note_selector,
    output logic pwm_signal
);

typedef enum logic [1:0] {
    SILENT,
    DO_s,
    RE_s,
    MI_s
} note_state_t;

localparam integer PW_DO = 191113;
localparam integer PW_RE = 170262;
localparam integer PW_MI = 151685;
localparam integer NOTE_DURATION = 100000000; 

note_state_t state = SILENT, next_state;
logic [31:0] pulse_width;
logic [31:0] timer, next_timer;

logic [31:0] pwm_counter;

always_comb begin
    next_state = state; 
    next_timer = timer;  

    case (state)
        DO_s: pulse_width = PW_DO;
        RE_s: pulse_width = PW_RE;
        MI_s: pulse_width = PW_MI;
        default: pulse_width = 0;  
    endcase

    if (start) begin
        if (timer >= NOTE_DURATION) begin
            case (state)
                DO_s: next_state = RE_s;
                RE_s: next_state = MI_s;
                MI_s: next_state = DO_s;
                default: next_state = SILENT;
            endcase
            next_timer = 0;  
        end else begin
            next_timer = timer + 1;  
        end
    end else begin
        next_state = SILENT;  
        next_timer = 0;      
    end
end

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= SILENT;
        timer <= 0;
        pwm_counter <= 0;
        pwm_signal <= 0;
    end else begin
        state <= next_state;
        timer <= next_timer;
        
        if (pwm_counter >= pulse_width) begin
            pwm_counter <= 0;
            pwm_signal <= ~pwm_signal; 
        end else begin
            pwm_counter <= pwm_counter + 1;
        end
    end
end

endmodule
