`timescale 1ns / 1ps

module mario_palette(
    input  [1:0]  palette_index,
    output logic [3:0] red, green, blue
    );
    always_comb
    begin
      case(palette_index)
      2'b00:
      begin
      	red = 4'hf;
      	green = 4'h4;
      	blue = 4'h0;
      end
      2'b01:
      begin
      	red = 4'hf;
      	green = 4'ha;
      	blue = 4'h4;
      end
      2'b10:
      begin
      	red = 4'hb;
      	green = 4'h8;
      	blue = 4'h0;
      end
      2'b11:
      begin
      	red = 4'h0;
      	green = 4'h0;
      	blue = 4'he;
      end
      	endcase
	end
endmodule



module bgup_palette(
    input  [1:0]  palette_index,
    output logic [3:0] red, green, blue
    );
    always_comb
    begin
      case(palette_index)
      2'b00:
      begin
      	red = 4'h6;
      	green = 4'ha;
      	blue = 4'hd;
      end
      2'b01:
      begin
      	red = 4'h0;
      	green = 4'h8;
      	blue = 4'h2;
      end
      2'b10:
      begin
      	red = 4'hf;
      	green = 4'hf;
      	blue = 4'hf;
      end
      2'b11:
      begin
      	red = 4'h0;
      	green = 4'h0;
      	blue = 4'h0;
      end
      	endcase
	end
endmodule


module bgdown_palette(
    input  [1:0]  palette_index,
    output logic [3:0] red, green, blue
    );
    always_comb
    begin
      case(palette_index)
      2'b00:
      begin
      	red = 4'h0;
      	green = 4'h8;
      	blue = 4'h2;
      end
      2'b01:
      begin
      	red = 4'h6;
      	green = 4'ha;
      	blue = 4'hd;
      end
      2'b10:
      begin
      	red = 4'hf;
      	green = 4'h5;
      	blue = 4'h1;
      end
      2'b11:
      begin
      	red = 4'h0;
      	green = 4'h0;
      	blue = 4'h0;
      end
      	endcase
	end
endmodule

module brick_palette(
    input palette_index,
    output logic [3:0] red, green, blue
    );
    always_comb
    begin
      case(palette_index)
      1'b0:
      begin
      	red = 4'h9;
      	green = 4'h5;
      	blue = 4'h0;
      end
      1'b1:
      begin
      	red = 4'h0;
      	green = 4'h0;
      	blue = 4'h0;
      end
      	endcase
	end
endmodule


module question_palette(
    input palette_index,
    output logic [3:0] red, green, blue
    );
    always_comb
    begin
      case(palette_index)
      1'b0:
      begin
      	red = 4'hf;
      	green = 4'hf;
      	blue = 4'hf;
      end
      1'b1:
      begin
      	red = 4'h0;
      	green = 4'h0;
      	blue = 4'h0;
      end
      	endcase
	end
endmodule

module monster_palette(
    input  [1:0]  palette_index,
    output logic [3:0] red, green, blue
    );
    always_comb
    begin
      case(palette_index)
      2'b00:
      begin
      	red = 4'hf;
      	green = 4'hc;
      	blue = 4'h9;
      end
      2'b01:
      begin
      	red = 4'h6;
      	green = 4'h3;
      	blue = 4'h0;
      end
      2'b10:
      begin
      	red = 4'h0;
      	green = 4'h0;
      	blue = 4'h0;
      end
      2'b11:
      begin
      	red = 4'ha;
      	green = 4'h7;
      	blue = 4'h4;
      end
      	endcase
	end
endmodule

module gameover_palette(
    input   palette_index,
    output logic [3:0] red, green, blue
    );
    always_comb
    begin
      case(palette_index)
      1'b0:
      begin
      	red = 4'hf;
      	green = 4'hf;
      	blue = 4'hf;
      end
      1'b1:
      begin
      	red = 4'h0;
      	green = 4'h0;
      	blue = 4'h0;
      end
      	endcase
	end
endmodule

module startpic_palette(
    input  [1:0]  palette_index,
    output logic [3:0] red, green, blue
    );
    always_comb
    begin
      case(palette_index)
      2'b00:
      begin
      	red = 4'hf;
      	green = 4'ha;
      	blue = 4'h9;
      end
      2'b01:
      begin
      	red = 4'hc;
      	green = 4'h5;
      	blue = 4'h1;
      end
      2'b10:
      begin
      	red = 4'h0;
      	green = 4'h0;
      	blue = 4'h0;
      end
      2'b11:
      begin
      	red = 4'hf;
      	green = 4'hf;
      	blue = 4'hf;
      end
      	endcase
	end
endmodule  

module starttext_palette(
    input  [1:0]  palette_index,
    output logic [3:0] red, green, blue
    );
    always_comb
    begin
      case(palette_index)
      2'b00:
      begin
      	red = 4'hf;
      	green = 4'hc;
      	blue = 4'h8;
      end
      2'b01:
      begin
      	red = 4'hf;
      	green = 4'h0;
      	blue = 4'h0;
      end
      2'b10:
      begin
      	red = 4'h0;
      	green = 4'h0;
      	blue = 4'h0;
      end
      2'b11:
      begin
      	red = 4'hf;
      	green = 4'hf;
      	blue = 4'hf;
      end
      	endcase
	end
endmodule

module coin_palette(
    input  [1:0]  palette_index,
    output logic [3:0] red, green, blue
    );
    always_comb
    begin
      case(palette_index)
      2'b00:
      begin
      	red = 4'h0;
      	green = 4'h0;
      	blue = 4'h0;
      end
      2'b01:
      begin
      	red = 4'hf;
      	green = 4'h0;
      	blue = 4'h0;
      end
      2'b10:
      begin
      	red = 4'he;
      	green = 4'hd;
      	blue = 4'h8;
      end
      2'b11:
      begin
      	red = 4'he;
      	green = 4'hb;
      	blue = 4'h4;
      end
      	endcase
	end
endmodule