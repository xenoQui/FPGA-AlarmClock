`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2023 11:42:32 AM
// Design Name: 
// Module Name: min
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


// minute counter
module min(
    input clk,
    input rst,
    input en,
    output reg [5:0] count,     // for simulation
    output reg out
    );
    
    always@(posedge clk)
    begin
        if(rst)
        begin
            count <= 0;
            out <= 0;
        end
        else if(en)
            count <= (count >= 59) ? 0 : count + 1;
        
        out <= (count >= 59) ? 1 : 0;
    end
        
endmodule
