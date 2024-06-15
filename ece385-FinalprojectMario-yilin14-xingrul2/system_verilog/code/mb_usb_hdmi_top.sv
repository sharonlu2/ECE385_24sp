//-------------------------------------------------------------------------
//    mb_usb_hdmi_top.sv                                                 --
//    Zuofu Cheng                                                        --
//    2-29-24                                                            --
//                                                                       --
//                                                                       --
//    Spring 2024 Distribution                                           --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module mb_usb_hdmi_top(
    input logic Clk,
    input logic reset_rtl_0,
    
    //USB signals
    input logic [0:0] gpio_usb_int_tri_i,
    output logic gpio_usb_rst_tri_o,
    input logic usb_spi_miso,
    output logic usb_spi_mosi,
    output logic usb_spi_sclk,
    output logic usb_spi_ss,
    
    //UART
    input logic uart_rtl_0_rxd,
    output logic uart_rtl_0_txd,
    
    //HDMI
    output logic hdmi_tmds_clk_n,
    output logic hdmi_tmds_clk_p,
    output logic [2:0]hdmi_tmds_data_n,
    output logic [2:0]hdmi_tmds_data_p,
        
    //HEX displays
    output logic [7:0] hex_segA,
    output logic [3:0] hex_gridA,
    output logic [7:0] hex_segB,
    output logic [3:0] hex_gridB,
    output logic pwmoutput,
    output logic pwmoutput2
);
    logic [7:0] total_score;
    logic divided_clk;
    logic [7:0] coin_score;
    logic [7:0] score_num_brick;
    logic [7:0] blockflags;
    logic [31:0] keycode0_gpio, keycode1_gpio;
    logic clk_25MHz, clk_125MHz, clk, clk_100MHz;
    logic locked;
    logic [9:0] drawX, drawY, ballysig, ballsizesig;
    logic [9:0] BallX_offset;
    logic hsync, vsync, vde;
    logic [3:0] red, green, blue;
        logic [3:0] red_text, green_text, blue_text;
            logic [3:0] red_game, green_game, blue_game;
    logic reset_ah;
    logic [9:0] block_y_1;
    logic [9:0] block_y_2;
    logic [9:0] block_y_3;
    logic [9:0] block_y_4;
    logic [9:0] block_y_5;
    logic [9:0] block_y_6;
    logic [9:0] block_y_7;
    logic [9:0] block_y_8;
    logic [9:0] x_monster;
    logic die_once;
    assign reset_ah = reset_rtl_0;
    int page_index;
    logic  [4:0] block_question;
    logic [31:0] allreg[7];
    logic [7:0] score_num;
    logic [1:0] life_num;
    logic monster_display;
    logic power_up;
    logic max_page;
    logic [1:0] game_state;
    logic [31:0] pwm_counter;
    logic pwm_signal;
    logic pwm_signal2;
    logic make_sound;
    logic [1:0] coin_image;
    assign total_score = score_num_brick + score_num +coin_score;
    logic [1:0] coin_image;
    
    logic [9:0] coin_x1, coin_x2, coin_x3, coin_x4,
                          coin_x5, coin_x6;
    logic [9:0] coin_y1, coin_y2, coin_y3, coin_y4,
                    coin_y5, coin_y6;
       assign coin_x1 = 640-BallX_offset;
       assign coin_x2 = 640-BallX_offset+30;
       assign coin_x3 = 640-BallX_offset+60;
       assign coin_x4 = 640-BallX_offset+150;
       assign coin_x5 = 640-BallX_offset+180;
       assign coin_x6 = 640-BallX_offset+210;
   
       
    assign pwmoutput = pwm_signal;
    assign pwmoutput2 = pwm_signal2;
    localparam integer PULSEWIDTH_DO = 191113;
    localparam integer PULSEWIDTH_RE = 170262;
    localparam integer PULSEWIDTH_MI = 151685;
   
    //logic [31:0] pulse_width = 32'd191570;
    int pulse_width = PULSEWIDTH_MI;


pwm_controller pwm_controller_inst(
    .Clk(Clk),
    .reset_rtl_0(reset_rtl_0),
    .make_sound(make_sound),
    .pulse_width(pulse_width),
    .pwm_signal(pwm_signal)
);
play_notes play_notes_inst(
    .clk(Clk),
    .reset(reset_rtl_0),
    .start(~make_sound),  // This signal acts like 'make_sound'
//    .note_selector(),
    .pwm_signal(pwm_signal2)
);
//always_comb begin
//    if (make_sound == 1)
//           pulse_width = 32'd191570;
//    else
//            pulse_width = 32'd150000; 
//end
 

//    parameter PERIOD = 32'b00110111011111001000; // Calculated for 440 Hz at 100 MHz clock
//    parameter PULSE_WIDTH = 32'b00110111011111001000;
//    pwm_core pwm_core_inst(
//    .rst_n(reset_rtl_0),
//    .clk(Clk),
//    .en(1'b1),
//    .period(PERIOD),
//    .pulse_width(PULSE_WIDTH),
//    .pwm(pwmoutput_)
//); 

//    logic [1:0] life_state;
    
//    always_ff @(posedge Clk)begin
//        if (reset_ah)
//             life_state <= 3;
//        else
//            life_state <= life_num;
//    end
    
//    logic  block_question_1;
//logic  block_question_2;
//logic  block_question_3;
//logic  block_question_4;
//logic  block_question_5;
//logic  block_question_6;
//logic  block_question_7;
//logic  block_question_8;
    
    //Keycode HEX drivers
    hex_driver HexA (
        .clk(Clk),
        .reset(reset_ah),
        .in({keycode0_gpio[31:28], keycode0_gpio[27:24], keycode0_gpio[23:20], keycode0_gpio[19:16]}),
        .hex_seg(hex_segA),
        .hex_grid(hex_gridA)
    );
    
    hex_driver HexB (
        .clk(Clk),
        .reset(reset_ah),
        .in({keycode0_gpio[15:12], keycode0_gpio[11:8], keycode0_gpio[7:4], keycode0_gpio[3:0]}),
        .hex_seg(hex_segB),
        .hex_grid(hex_gridB)
    );
    
    mb_block mb_block_i (
        .clk_100MHz(Clk),
        .gpio_usb_int_tri_i(gpio_usb_int_tri_i),
        .gpio_usb_keycode_0_tri_o(keycode0_gpio),
        .gpio_usb_keycode_1_tri_o(keycode1_gpio),
        .gpio_usb_rst_tri_o(gpio_usb_rst_tri_o),
        .reset_rtl_0(~reset_ah), //Block designs expect active low reset, all other modules are active high
        .uart_rtl_0_rxd(uart_rtl_0_rxd),
        .uart_rtl_0_txd(uart_rtl_0_txd),
        .usb_spi_miso(usb_spi_miso),
        .usb_spi_mosi(usb_spi_mosi),
        .usb_spi_sclk(usb_spi_sclk),
        .usb_spi_ss(usb_spi_ss)
    );
        
    //clock wizard configured with a 1x and 5x clock for HDMI
    clk_wiz_0 clk_wiz (
        .clk_out1(clk_25MHz),
        .clk_out2(clk_125MHz),
        .reset(reset_ah),
        .locked(locked),
        .clk_in1(Clk)
    );
    
    //VGA Sync signal generator
    vga_controller vga (
        .pixel_clk(clk_25MHz),
        .reset(reset_ah),
        .hs(hsync),
        .vs(vsync),
        .active_nblank(vde),
        .drawX(drawX),
        .drawY(drawY)
    );    

    //Real Digital VGA to HDMI converter
    hdmi_tx_0 vga_to_hdmi (
        //Clocking and Reset
        .pix_clk(clk_25MHz),
        .pix_clkx5(clk_125MHz),
        .pix_clk_locked(locked),
        //Reset is active LOW
        .rst(reset_ah),
        //Color and Sync Signals
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync),
        .vde(vde),
        
        //aux Data (unused)
        .aux0_din(4'b0),
        .aux1_din(4'b0),
        .aux2_din(4'b0),
        .ade(1'b0),
        
        //Differential outputs
        .TMDS_CLK_P(hdmi_tmds_clk_p),          
        .TMDS_CLK_N(hdmi_tmds_clk_n),          
        .TMDS_DATA_P(hdmi_tmds_data_p),         
        .TMDS_DATA_N(hdmi_tmds_data_n)          
    );
    
    text_mapper text_mapper_inst(
        .DrawX(drawX),
        .DrawY(drawY),
        .Red(red_text),
        .Green(green_text),
        .Blue(blue_text),
        .allreg(allreg)    );
    
    reg_writing reg_writing_inst(
    .score_num(total_score),
    .life_num(life_num),
    .reg_font(allreg)
    );

//    coin_image_change coin_image_change_inst(
//    .clk(divided_clk),         // Clock input
//    .rst_n(~reset_ah),       // Asynchronous reset, active low
//    .out(coin_image)    // 2-bit output that cycles through 0, 1, 2
//);
    
    //Color Mapper Module   
    color_mapper color_instance(
    .max_page(max_page),
    .scored(scored),
    .frame_clk(vsync),
    .reset(reset_ah),
    .divided_clk(divided_clk),
    .keycode(keycode0_gpio[7:0]),
        .Clk(Clk),
        .mario_y(ballysig),
//        .luigi_x(ballysig),
//        .luigi_y(ballysig),
        .BallX_offset(BallX_offset),
        .DrawY(drawY),
        .DrawX(drawX),
        .Red(red_game),
        .Green(green_game),
        .Blue(blue_game),
        .block_y_1(block_y_1),
         .block_y_2(block_y_2),
        .block_y_3(block_y_3),
        .block_y_4(block_y_4),
        .block_y_5(block_y_5),
        .block_y_6(block_y_6),
         .block_y_7(block_y_7),
        .block_y_8(block_y_8),
        .block_question(block_question),
         .x_monster(x_monster),
         .game_state(game_state),
        .coin_x1(coin_x1), .coin_x2(coin_x2), .coin_x3(coin_x3), .coin_x4(coin_x4),
        .coin_x5(coin_x5), .coin_x6(coin_x6), 
        .coin_y1(coin_y1), .coin_y2(coin_y2), .coin_y3(coin_y3), .coin_y4(coin_y4),
        .coin_y5(coin_y5), .coin_y6(coin_y6)
);
   
   statemachine statemachine_instance(
   .speed(power_up),
        .reset(reset_ah),        
        .frame_clk(vsync),                    //Figure out what this should be so that the ball will move
        .keycode(keycode0_gpio[7:0]),    //Notice: only one keycode connected to ball by default
        .BallX_offset(BallX_offset),
        .BallY(ballysig),
        .page_index(page_index), 
         .blocky1(block_y_1),
        .blocky5(block_y_5),
        .blocky6(block_y_6),
         .blocky7(block_y_7),
        .blocky8(block_y_8),
        .blockflags(blockflags),
        .game_state(game_state)
   );
   
       track_max_page_index tracker(
        .clk(vsync),
        .page_index(page_index),
        .max_page(max_page)
    );
   
   animation_clk animation_clk_inst(
   .clk(Clk),
   .rst_n(~reset_ah),
   .divided_clk(divided_clk)
   );

  coins CoinCollector0(
    .clk(vsync),
    .reset(reset_ah),
    .power_up(power_up),
    .coin_x(coin_x1),
    .coin_y(block_y_1 -30),
    .character_x(10'd320),
    .character_y(ballysig),
    .new_coin_y(coin_y1),
    .score(coin_score1),
    .game_state(game_state),
    .move_enable(move_enable)
);


   coins CoinCollector1(
    .clk(vsync),
    .reset(reset_ah),
    .power_up(power_up),
    .coin_x(coin_x2),
    .coin_y(block_y_2 -30),
    .character_x(10'd320),
    .character_y(ballysig),
    .new_coin_y(coin_y2),
    .score(coin_score2),
    .game_state(game_state),
    .move_enable(move_enable)
);


   coins CoinCollector2(
    .clk(vsync),
    .reset(reset_ah),
    .power_up(power_up),
    .coin_x(coin_x3),
    .coin_y(block_y_3 -30),
    .character_x(10'd320),
    .character_y(ballysig),
    .new_coin_y(coin_y3),
    .score(coin_score3),
    .game_state(game_state),
    .move_enable(move_enable)
);


   coins CoinCollector3(
    .clk(vsync),
    .reset(reset_ah),
    .power_up(power_up),
    .coin_x(coin_x4),
    .coin_y(block_y_4 -30),
    .character_x(10'd320),
    .character_y(ballysig),
    .new_coin_y(coin_y4),
    .score(coin_score4),
    .game_state(game_state),
    .move_enable(move_enable)
);


   coins CoinCollector4(
    .clk(vsync),
    .reset(reset_ah),
    .power_up(power_up),
    .coin_x(coin_x5),
    .coin_y(block_y_5 -30),
    .character_x(10'd320),
    .character_y(ballysig),
    .new_coin_y(coin_y5),
    .score(coin_score5),
    .game_state(game_state),
    .move_enable(move_enable)
);

   coins CoinCollector5(
    .clk(vsync),
    .reset(reset_ah),
    .power_up(power_up),
    .coin_x(coin_x6),
    .coin_y(block_y_6 -30),
    .character_x(10'd320),
    .character_y(ballysig),
    .new_coin_y(coin_y6),
    .score(coin_score6),
    .game_state(game_state),
    .move_enable(move_enable)
);
   
      
   bricks bricks_inst(
   .reset(reset_ah),        
   .frame_clk(vsync),
   .page_index(page_index),
   .block_y_1(block_y_1),
         .block_y_2(block_y_2),
        .block_y_3(block_y_3),
        .block_y_4(block_y_4),
        .block_y_5(block_y_5),
        .block_y_6(block_y_6),
         .block_y_7(block_y_7),
        .block_y_8(block_y_8),
        .block_question(block_question)
           );
           
       score_keeping score_keeping_inst(
       .clk(vsync),
           .reset(reset_ah),
   .blockflags(blockflags),
    .block_question(block_question),         
    .score_number(score_num_brick), // Data out
    .scored(scored),
    .max_page(max_page),
    .game_state(game_state),
    .make_sound(make_sound)
       );
       
       monsters monsters_inst(
        .frame_clk(vsync),        
        .char_y(ballysig),     
        .max_page(max_page),         
        .monster_x(x_monster), 
        .life(life_num),      
        .score(score_num),     
        .power_up(power_up),              
      .page_index(page_index),
      .game_state(game_state) );
       
    game_display_controller game_display_controller_inst(
    .clk(vsync),
    .reset(reset_ah),
    .key_code_raw(keycode0_gpio[7:0]),
    .lives(life_num),
    .state_out(game_state)  
);          
       always_comb
       begin
       if((drawY < 10'd15 )&(drawX < 10'd224))
       begin
      if (game_state == 1) begin
       red = red_text;
       blue = blue_text;
       green = green_text;
       end
       else begin
       red = red_game;
       blue = blue_game;
       green = green_game;          
       end
       end
       else
       begin
       red = red_game;
       blue = blue_game;
       green = green_game;      
       end
end       
          
    
    
    
endmodule
