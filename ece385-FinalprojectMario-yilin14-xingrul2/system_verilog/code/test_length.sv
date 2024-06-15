`timescale 1ns / 1ps

module ArithmeticOperations (
    input logic [31:0] a,      
    input logic [15:0] b,      
    output logic [10:0] result 
);

    // Internal signals to match operand sizes
//    logic [15:0] a_extended;

    // Extend the smaller input to match the size of the larger input
//    assign a_extended = { {8{a[7]}}, a }; // Sign extension for signed arithmetic

    // Perform the operation based on the control signal
    always_comb begin
            result = (a - 320);
    end

endmodule
