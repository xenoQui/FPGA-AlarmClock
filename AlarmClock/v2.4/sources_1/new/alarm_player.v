`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 07:47:16 PM
// Design Name: 
// Module Name: alarm_player
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alarm_player(
                    input clk,
                    input rst,
                    input player_en,
                    output alarm_r, alarm_g, alarm_b,             
                    output reg audio_out, aud_sd             
                    );
  
    reg [19:0] counter;
    reg [31:0] time1, noteTime;
    reg [9:0] number;
    wire [4:0] duration;
    wire [19:0] notePeriod;
    parameter clockFrequency = 100_000_000;
    
    alarm_sound aud(
                    .number(number),          //case statement input   
                    .note(notePeriod),        //note frequency
                    .duration(duration)       //note length
                    );
    
    alarm_match_rgb_led led_driver(
                    .clk(clk),                 // Clock input
                    .led_enable(player_en),
                    .PWM_r(alarm_r),           // Red LED
                    .PWM_g(alarm_g),           // Green LED
                    .PWM_b(alarm_b)            // Blue LED
                );
    
    always@(posedge clk) 
      begin
        if (~player_en | rst)
            begin
                counter <= 0;
                time1 <= 0;
                audio_out <= 1;
            end

        aud_sd = 1;                            //audio enable
        counter <= counter + 1;                //increment counter
        time1 <= time1 + 1;                       //increment time1
        
        if(counter >= notePeriod)              //square wave at desired frequency
           begin
                counter <= 0;
                audio_out <= ~audio_out ; 
           end                                  //toggle audio output 
        
        if(time1 >= noteTime)                   //note duration
            begin
                time1 <= 0;
                number <= number + 1; 
            end                                 //play next note
      end

  always @(duration)
    begin
      noteTime = (duration * clockFrequency/8);  //number of FPGA clock periods in one note.
    end
      
endmodule
