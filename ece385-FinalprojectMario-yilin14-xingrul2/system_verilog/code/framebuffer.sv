`timescale 1ns / 1ps
module FrameBuffer #(
    parameter ADDR_WIDTH = 17, // Enough for 307200 pixels, one address per pixel
    parameter DATA_WIDTH = 3   // Storing 3 bits per pixel
)(
    input logic clk,
    input logic we,             // Write enable
    input logic [ADDR_WIDTH-1:0] addr,
    input logic [DATA_WIDTH-1:0] din, // Data in
    output logic [DATA_WIDTH-1:0] dout // Data out
);
    // Define the memory array
    logic [DATA_WIDTH-1:0] mem [(1 << ADDR_WIDTH)-1:0];

    // Write operation
    always_ff @(posedge clk) begin
        if (we) begin
            mem[addr] <= din;
        end
    end

    // Read operation
    assign dout = mem[addr];
endmodule
