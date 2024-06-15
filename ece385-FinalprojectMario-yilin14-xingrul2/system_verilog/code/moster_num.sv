`timescale 1ns / 1ps
module monster_num(
    input logic clk,            // Clock signal
    input logic reset,          // Reset signal
    input logic touch_v,        // Vertical touch signal
    input logic touched,        // Any touch signal
    input logic [31:0] page_index, // Current page index
    output logic [7:0] monster_num, // Count of monster touches
    output logic monster_display    // Display control for monster
);

    logic [31:0] max_page_index = 0; // To store the maximum page index seen
    logic touch_v_prev = 0;          // To store the previous state of touch_v

    // Process touch_v and manage monster_num
    always_ff @(posedge clk) begin
        if (reset) begin
            monster_num <= 0;
            max_page_index <= 0;
            touch_v_prev <= 0;
        end else begin
            // Update max_page_index if the current page_index is greater
            if (page_index > max_page_index) begin
                max_page_index <= page_index;
            end

            // Check for transition of touch_v from 0 to 1 and increment monster_num
            if (touch_v && !touch_v_prev && page_index == max_page_index) begin
                monster_num <= monster_num + 1;
            end

            // Update the previous state of touch_v
            touch_v_prev <= touch_v;
        end
    end

    // Control the monster_display output
    always_ff @(posedge clk) begin
        if (reset) begin
            monster_display <= 0;
        end else begin
            // Set monster_display to 1 only if touched is 0 and current page is the max page
            monster_display <= (~touched && page_index == max_page_index) ? 1 : 0;
        end
    end

endmodule