`timescale 1ns / 1ps

// refernce: from the helper tool provided on the coursepage
module pic1(
		input [1:0] data_In,
		input [9:0]  read_address, write_address, 
		input we, Clk,

		output logic [1:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [1:0] mem [0:899];

initial
begin
	 $readmemh("D:/lab6/project_lab6/pictures/mariorun.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	   data_Out<= mem[read_address];
end

endmodule

module bg1(
		input [1:0] data_In,
		input [17:0]  read_address, write_address, 
		input we, Clk,

		output logic [1:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [1:0] mem [0:153599];

initial
begin
	 $readmemh("D:/lab6/project_lab6/pictures/background_crop_up.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	   data_Out<= mem[read_address];
end

endmodule

module bg2(
		input [1:0] data_In,
		input [17:0]  read_address, write_address, 
		input we, Clk,

		output logic [1:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [1:0] mem [0:153599];

initial
begin
	 $readmemh("D:/lab6/project_lab6/pictures/background_crop_low.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	   data_Out<= mem[read_address];
end

endmodule


module brick(
		input [1:0] data_In,
		input [9:0]  read_address, write_address, 
		input we, Clk,

		output logic [1:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [1:0] mem [0:783];

initial
begin
	 $readmemh("D:/lab6/project_lab6/pictures/brick.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	   data_Out<= mem[read_address];
end

endmodule




module question(
		input [1:0] data_In,
		input [9:0]  read_address, write_address, 
		input we, Clk,

		output logic [1:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [1:0] mem [0:783];

initial
begin
	 $readmemh("D:/lab6/project_lab6/pictures/question.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	   data_Out<= mem[read_address];
end

endmodule


module mario_stand(
		input [1:0] data_In,
		input [9:0]  read_address, write_address, 
		input we, Clk,

		output logic [1:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [1:0] mem [0:899];

initial
begin
	 $readmemh("D:/lab6/project_lab6/pictures/mario_stand.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	   data_Out<= mem[read_address];
end

endmodule


module monster_pic(
		input [1:0] data_In,
		input [9:0]  read_address, write_address, 
		input we, Clk,

		output logic [1:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [1:0] mem [0:899];

initial
begin
	 $readmemh("D:/lab6/project_lab6/pictures/goomba.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	   data_Out<= mem[read_address];
end

endmodule

module gameover(
		input [1:0] data_In,
		input [14:0]  read_address, write_address, 
		input we, Clk,

		output logic [1:0] data_Out
);

// mem has width of 2 bits and a total of 10000 addresses
logic [1:0] mem [0:19999];

initial
begin
	 $readmemh("D:/lab6/project_lab6/pictures/gameover.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	   data_Out<= mem[read_address];
end

endmodule

module start_text(
		input [1:0] data_In,
		input [13:0]  read_address, write_address, 
		input we, Clk,

		output logic [1:0] data_Out
);

// mem has width of 2 bits and a total of 10000 addresses
logic [1:0] mem [0:15999];

initial
begin
	 $readmemh("D:/lab6/project_lab6/pictures/start_text.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	   data_Out<= mem[read_address];
end

endmodule

module start_pic(
		input [1:0] data_In,
		input [14:0]  read_address, write_address, 
		input we, Clk,

		output logic [1:0] data_Out
);

// mem has width of 2 bits and a total of 10000 addresses
logic [1:0] mem [0:28799];

initial
begin
	 $readmemh("D:/lab6/project_lab6/pictures/start_pic.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	   data_Out<= mem[read_address];
end

endmodule

module coin_1(
		input [1:0] data_In,
		input [9:0]  read_address, write_address, 
		input we, Clk,

		output logic [1:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [1:0] mem [0:899];

initial
begin
	 $readmemh("D:/lab6/project_lab6/pictures/coin1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	   data_Out<= mem[read_address];
end

endmodule