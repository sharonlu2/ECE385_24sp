`timescale 1ns / 1ps


module animation_clk(
input logic clk,         // Input clock
input logic rst_n,       
output logic divided_clk  
);
localparam integer DIVIDE_FACTOR = 15360000;

logic [31:0] counter = 0;  
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 0;
        divided_clk <= 1'b0;
    end else begin
        if (counter == DIVIDE_FACTOR - 1) begin
            divided_clk <= ~divided_clk;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
end

endmodule
