`timescale 1ns / 1ps

module track_max_page_index(
    input logic clk,               
    input logic [31:0] page_index, 
    output logic max_page          );

      logic [31:0] max_page_index = 0; 
    logic [31:0] last_page_index = 0; 

    always_ff @(posedge clk) begin
        if (page_index != last_page_index) begin
           last_page_index <= page_index;
            if (page_index > max_page_index) begin
                max_page_index <= page_index; 
                max_page <= 1;                
                            end else begin
                max_page <= 0;               
                            end
        end
          end

endmodule