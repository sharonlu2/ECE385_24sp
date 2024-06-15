`timescale 1ns / 1ps

module text_mapper( input  logic [9:0]  DrawX, DrawY,
                    input  logic [31:0] allreg[7],
                    output logic [3:0]  Red, Green, Blue );
    logic is_char;
    int index;
    int x_index;
    logic [10:0] color_mask;
    int reg_index;
    logic invert;
    assign x_index = (DrawX%32)/8;
    assign reg_index = (DrawY/16 * 20 + DrawX/32);
    always_comb
    begin
    unique case(x_index)
            2'b00: begin 
            index = (allreg[reg_index][6:0]) * 16 + DrawY%16;
            invert = allreg[reg_index][7];
            end
            2'b01: begin
            index = (allreg[reg_index][14:8]) * 16 + DrawY%16;
            invert = allreg[reg_index][15];
            end
            2'b10: begin
            index = (allreg[reg_index][22:16]) * 16 + DrawY%16;
            invert = allreg[reg_index][23];
            end
            2'b11: begin
            index = (allreg[reg_index][30:24]) * 16 + DrawY%16; 
            invert = allreg[reg_index][31]; 
            end
            endcase
     end 
     
font_rom font_rom0(.addr(index),
				  .data(color_mask)
					 );
   assign is_char = color_mask[7-DrawX%8];
    always_comb
    begin:RGB_Display
        if ((is_char == 1'b1)&(invert == 1'b0 )) begin 
            Red = 4'h0;
            Green = 4'h0;
            Blue = 4'h0;
        end       
        else if((is_char == 1'b1)&(invert == 1'b1 ))
        begin
            Red = 4'hf;
            Green = 4'h0;
            Blue = 4'h0;        
        end
        else begin 
            Red = 4'h6; 
            Green = 4'ha;
            Blue = 4'hd;
        end      
    end 
    
endmodule
