`timescale 1ns / 1ps

module  statemachine 
( 
    
    input  logic        reset, 
    input  logic        frame_clk,
//    input  logic        Clk,
    input  logic [7:0]  keycode,
    input logic [9:0] blocky1,blocky5,blocky6,blocky7,blocky8,
//    input logic [9:0] Blcoky1,Blocky2,Blocky3,Blocky4,Blocky5,Blocky6,Blocky7,Blocky8,
    input logic speed,
    output int page_index,
    output logic [9:0] BallX_offset, 
    output logic [9:0]  BallY,
    output logic [7:0] blockflags,
    input logic [1:0] game_state
//    output logic [9:0]  BallS 
);


    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=344;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis


    logic signed [31:0] BallX;
    logic signed [31:0] Ball_X_Motion;
    logic signed [31:0] Ball_X_Motion_next;
    logic signed [31:0] Ball_X_next;
    logic [9:0] Ball_Y_Motion;
    logic [9:0] Ball_Y_Motion_next;

    logic [9:0] Ball_Y_next;
    logic [9:0] count,countnext;
    logic [9:0] Blocky1,Blocky2,Blocky3,Blocky4,Blocky5,Blocky6,Blocky7,Blocky8;
    logic [7:0] Blockflags;
    logic [7:0] Blockflags_next;
    int previous_page_index;
    assign Blocky1 = blocky1;
    assign Blocky2 = 50;
    assign Blocky3 = 50;
    assign Blocky4 = 50;
    assign Blocky5 = blocky5;
    assign Blocky6 = blocky6;
    assign Blocky7 = blocky7;
    assign Blocky8 = blocky8;
    assign BallX_offset = (BallX%640 + 640)%640;
    assign page_index = BallX/640;
    assign blockflags = Blockflags;
    
// mario state
	enum logic [3:0] {
		jump_state,fall_state,run_state,keep_falling
	} curr_state, next_state; 
// mario state switch
// Assign outputs based on state
	always_comb
	begin
		next_state  = curr_state;	//required because I haven't enumerated all possibilities below. Synthesis would infer latch without this
        Blockflags_next = Blockflags;	
		unique case (curr_state)
            jump_state :begin
                if (countnext == 70 ) begin
                    next_state = fall_state;
                end
//                 else begin
//                    next_state = jump_state;
//                end       
            // check brick blocks
               else if (BallX_offset + 30 >= 320 && BallX_offset < 432 && Ball_Y_next == Blocky1 + 28) begin
                    next_state = fall_state;
                    if (BallX_offset >= 305 && BallX_offset < 333)
                        Blockflags_next = Blockflags | 8'b00000001;
                    else if (BallX_offset >= 333 && BallX_offset < 351)
                        Blockflags_next = Blockflags | 8'b00000010;
                    else if (BallX_offset >= 351 && BallX_offset < 379)
                        Blockflags_next = Blockflags | 8'b00000100;
                    else if (BallX_offset >= 407 && BallX_offset < 435)
                        Blockflags_next = Blockflags | 8'b00001000;
                    else
                        Blockflags_next = Blockflags;
                end //brick1-4
                else if (BallX_offset + 30 >= 460 &&  BallX_offset < 488 && Ball_Y_next == Blocky5 + 28) begin
                    next_state = fall_state;
                    Blockflags_next = Blockflags;
                    if (BallX_offset >= 445 && BallX_offset < 473)
                        Blockflags_next = Blockflags|8'b00010000;  
                    else
                        Blockflags_next = Blockflags;
                end//brick5
                else if (BallX_offset + 30 >= 488 &&  BallX_offset < 516 && Ball_Y_next == Blocky6 + 28) begin
                    next_state = fall_state;
                    Blockflags_next = Blockflags;
                    if (BallX_offset >= 473 && BallX_offset < 501)
                        Blockflags_next = Blockflags|8'b00100000; 
                    else 
                        Blockflags_next = Blockflags;                        
                end//brick6
                else if (BallX_offset + 30 >= 516 &&  BallX_offset < 544 && Ball_Y_next == Blocky7 + 28) begin
                    next_state = fall_state;
                    Blockflags_next = Blockflags;
                    if (BallX_offset >= 501 && BallX_offset < 529)
                        Blockflags_next = Blockflags|8'b1000000;
                    else
                        Blockflags_next = Blockflags;                        
                end//brick7
                else if (BallX_offset + 30 >= 544 &&  BallX_offset < 572 && Ball_Y_next == Blocky8 + 28) begin
                    next_state = fall_state;
                    Blockflags_next = Blockflags;
                    if (BallX_offset >= 529 && BallX_offset < 557)
                        Blockflags_next = Blockflags|8'b10000000; 
                    else
                        Blockflags_next = Blockflags;    
                end//brick8
                else begin
                    next_state = jump_state;
                end   
              end 
            run_state: begin
                if (keycode == 8'h1A) begin
                    next_state = jump_state;
                end
                else if (Ball_Y_next + 30 <= Blocky1) begin
                    if (BallX_offset <= 290)
                        next_state = keep_falling;
                //    else if(BallX_offset <= 448 && Ball_Y_next + 30 <= Blocky5) //!!!
                    else if(BallX_offset <= 435 && BallX_offset > 432)
                       next_state = keep_falling;   //fall from 2nd to 1st bricks  //must be here
                    else if(BallX_offset >= 572 && Ball_Y_next + 30 <= Blocky8)//!!!
                       next_state = keep_falling;   //fall from 2nd to the floor  //must be here
                    else
                        next_state = run_state;//!!!!
                end     //fall from the first block
                else if (Ball_Y_next + 30 <= Blocky8) begin
                    if (BallX_offset >= 572) //!!!
                        next_state = keep_falling;
                    else
                        next_state = run_state;//!!!!
                end     //fall from the second block                
                else begin
                    next_state = run_state;
                end
            end //run end
            fall_state: begin
                if (countnext == 0) begin
                    if (BallX_offset >= 432 && BallX_offset < 440 && Ball_Y_next + 30 == Blocky1) begin
                        next_state = keep_falling;
                    end //fall from a brick
                    else if (BallX_offset >= 572 && Ball_Y_next + 30 == Blocky8) begin
                        next_state = keep_falling;
                    end //fall from a brick
                    else if (BallX_offset >= 572 && Blocky8 < Blocky1 && Ball_Y_next + 30 == Blocky1) begin
                        next_state = keep_falling; //fix buggy fall from first lower block
                    end //fall from a brick
                    else if (BallX_offset <= 290 && Blocky1 < Blocky8 && Ball_Y_next + 30 == Blocky8) begin
                        next_state = keep_falling; //fix buggy fall from second lower block
                    end
                    else if (BallX_offset >= 432 && Blocky1 < Blocky8 && Ball_Y_next + 30 == Blocky1) begin
                        next_state = keep_falling; //fix buggy fall from first higher block
                    end //fall from a brick
                    else if (BallX_offset >= 460 && BallX_offset < 488 && Ball_Y_next + 30 < Blocky5) //!!change when y different
                        next_state = keep_falling;
                    else if (BallX_offset >= 488 && BallX_offset < 506 && Ball_Y_next + 30 < Blocky6) //!!change when y different
                        next_state = keep_falling;
                    else if (BallX_offset >= 516 && BallX_offset < 544 && Ball_Y_next + 30 < Blocky7) //!!change when y different
                        next_state = keep_falling;
                    else if (BallX_offset >= 544 && BallX_offset < 572 && Ball_Y_next + 30 < Blocky8) //!!change when y different
                        next_state = keep_falling;
                    else if (BallX_offset >= 460 && BallX_offset < 572 && Ball_Y_next + 30 <= Blocky1 && Ball_Y_next + 30 > Blocky5)
                        next_state = keep_falling;//!!
                    else begin
                        next_state = run_state;
                    end
                end
                else if (BallX_offset >= 290 &&  BallX_offset < 432) begin
                    if (Ball_Y_next + 30 == Blocky1) //!!!
                    next_state = run_state;
                end
                else if (BallX_offset >= 460 &&  BallX_offset < 572) begin
                    if (Ball_Y_next + 30 == Blocky5 || Ball_Y_next + 30 == Blocky6 || Ball_Y_next + 30 == Blocky7 || Ball_Y_next + 30 == Blocky8)
                    next_state = run_state;
                end
                else begin
                    next_state = fall_state;
                end
            end
            keep_falling: begin
                if (Ball_Y_next >= 344) begin
                    next_state = run_state;
                end
                else if (BallX_offset >= 290 && BallX_offset < 432 && Ball_Y_next + 30 == Blocky1) begin
                    next_state = run_state;
                end
                else if (BallX_offset >= 460 && BallX_offset < 488 && Ball_Y_next + 30 == Blocky5) //!!change when y different
                    next_state = run_state;
                else if (BallX_offset >= 488 && BallX_offset < 506 && Ball_Y_next + 30 == Blocky6) //!!change when y different
                    next_state = run_state;
                else if (BallX_offset >= 516 && BallX_offset < 544 && Ball_Y_next + 30 == Blocky7) //!!change when y different
                    next_state = run_state;
                else if (BallX_offset >= 544 && BallX_offset < 572 && Ball_Y_next + 30 == Blocky8) //!!change when y different
                    next_state = run_state;
                else begin
                    next_state = keep_falling;
                end
            end
        endcase
	end
    
//state case operations
//    always_comb begin
//        Ball_Y_Motion_next = Ball_Y_Motion; // set default motion to be same as prev clock cycle 
//        Ball_X_Motion_next = Ball_X_Motion;
//        countnext = count; //
//        //check the keycode of left and right movement
//        if (keycode == 8'h04)
//        begin
//       if ((BallX_offset >= 404) && (BallX_offset <= 432) && (Ball_Y_next < Blocky1 + 28 && (Ball_Y_next > Blocky1 - 30)))
//           Ball_X_Motion_next = 0; //brick detection right
//       else if ((BallX_offset >= 544) && (BallX_offset <= 572) && (Ball_Y_next < Blocky8 + 28 && Ball_Y_next > Blocky8 - 30))
//            Ball_X_Motion_next = 0; //brick detection right
//        else if (speed) Ball_X_Motion_next = -10'd4;
//        else Ball_X_Motion_next = -10'd2;
//        end
//        else if (keycode == 8'h07)
//        begin
//         if ((BallX_offset == 290) && (Ball_Y_next < Blocky1 + 28 && Ball_Y_next > Blocky1 - 30))
//            Ball_X_Motion_next = 0; //brick detection left
//       else if ((BallX_offset == 440) && (Ball_Y_next < Blocky5 + 28 && Ball_Y_next > Blocky5 - 30))
//           Ball_X_Motion_next = 0; //brick detection left
//       else if (speed)            
//       Ball_X_Motion_next = 10'd4;    
//       Ball_X_Motion_next = 10'd4;    
//       else Ball_X_Motion_next = 10'd2;
//        end
//        else begin
//            Ball_X_Motion_next = 0;
//        end

always_comb begin
        Ball_Y_Motion_next = Ball_Y_Motion; // set default motion to be same as prev clock cycle 
        Ball_X_Motion_next = Ball_X_Motion;
        countnext = count; //
        //check the keycode of left and right movement
        if (keycode == 8'h04)
        begin
         if ((BallX_offset >= 290) && (BallX_offset <= 294) && (BallY < Blocky1 + 28 && BallY > Blocky1 - 30))
            Ball_X_Motion_next = 0; //brick detection left
       else if ((BallX_offset <= 432) && (BallX_offset >= 428)&& (BallY < Blocky1 + 28 && BallY > Blocky1 - 30))
           Ball_X_Motion_next = 0; //brick detection right
       else if ((BallX_offset >= 430) && (BallX_offset <= 460) && (BallY < Blocky5 + 28 && BallY > Blocky5 - 30))
           Ball_X_Motion_next = 0; //brick detection left
        else if ((BallX_offset <= 572) && (BallX_offset >= 568) && (BallY < Blocky8 + 28 && BallY > Blocky8 - 30))
            Ball_X_Motion_next = 0; //brick detection right
        else if (speed == 1)
            Ball_X_Motion_next = -10'd4;
        else 
             Ball_X_Motion_next = -10'd2;           
        end
        else if (keycode == 8'h07)
        begin
         if ((BallX_offset >= 290) && (BallX_offset <= 294) && (BallY < Blocky1 + 28 && BallY > Blocky1 - 30))
            Ball_X_Motion_next = 0; //brick detection left
       else if ((BallX_offset <= 432) && (BallX_offset >= 428) && (BallY < Blocky1 + 28 && BallY > Blocky1 - 30))
           Ball_X_Motion_next = 0; //brick detection right
       else if ((BallX_offset >= 430) && (BallX_offset <= 460) && (BallY < Blocky5 + 28 && BallY > Blocky5 - 30))
           Ball_X_Motion_next = 0; //brick detection left
        else if ((BallX_offset <= 572) && (BallX_offset >= 568) && (BallY < Blocky8 + 28 && BallY > Blocky8 - 30))
            Ball_X_Motion_next = 0; //brick detection right //latest change
        else if (speed == 1)
            Ball_X_Motion_next = 10'd4;
        else 
             Ball_X_Motion_next = 10'd2; 
        end  
        else begin
            Ball_X_Motion_next = 0;
        end
    unique case (curr_state)
        jump_state: begin
            Ball_Y_Motion_next = -10'd2;
            countnext = count + 1;
        end
        fall_state: begin
            Ball_Y_Motion_next = 10'd2;
            countnext = count - 1;
        end
        keep_falling: begin
            Ball_Y_Motion_next = 10'd2;
            countnext = 0;
        end
        run_state: begin
            countnext = 0;
            Ball_Y_Motion_next = 0;
        end       
    endcase
    end

    assign BallS = 30;  // default ball size
    assign Ball_X_next = (BallX + Ball_X_Motion_next);
    assign Ball_Y_next = (BallY + Ball_Y_Motion_next);
   
    always_ff @(posedge frame_clk) 
    begin: Move_Ball
        if (reset)
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
			Ball_X_Motion <= 10'd0; //Ball_X_Step;
            
			BallY <= Ball_Y_Center;
			BallX <= 0;
			curr_state <= run_state;
            Blockflags <= 0;
            previous_page_index <= 0;
//            Blockflags_next <= 0; ??
        end
        else 
        begin  
            if (game_state == 2'b10)begin
			BallY <= Ball_Y_Center;
			BallX <= 0;    
			previous_page_index <= 0;
			end            
			curr_state <= next_state;
            count <= countnext; //counter increments
			Ball_Y_Motion <= Ball_Y_Motion_next; 
			Ball_X_Motion <= Ball_X_Motion_next; 

            BallY <= Ball_Y_next;  // Update ball position
            BallX <= Ball_X_next;
            if (page_index != previous_page_index) begin
                Blockflags <= 0; // Reset blockflags when page_index changes
                previous_page_index <= page_index; // Update previous page_index
            end	
            else
                Blockflags <= Blockflags_next;               		
		end  
    end
      
endmodule