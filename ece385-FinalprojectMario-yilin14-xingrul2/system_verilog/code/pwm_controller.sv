`timescale 1ns / 1ps

module pwm_controller (
    input logic Clk,
    input logic reset_rtl_0,
    input logic make_sound,
    input logic [31:0] pulse_width,
    output logic pwm_signal
);

logic [31:0] counter = 32'd0;

always_ff @(posedge Clk or posedge reset_rtl_0) begin
    if(reset_rtl_0)begin
        counter <= 32'd0;;
        pwm_signal <= 1'b0;
    end
    else begin
        if (make_sound) begin
            if(counter < pulse_width)begin
                counter <= counter + 1'b1;
                pwm_signal <= pwm_signal;
            end
            else begin
                counter <= 32'd0;;
                pwm_signal <= ~pwm_signal;
               end 
        end //on
        else begin
            counter <= 32'd0;;
            pwm_signal <= 1'b0; //off
        end
    end
end

endmodule
