`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/11 20:40:32
// Design Name: 
// Module Name: light
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

module light(
inout clk,reset,power_on,light,
output reg light_on
    );
    always @(posedge clk,posedge reset)begin
        if(reset)begin
            light_on<=0;
        end
        else begin
            if(~power_on)begin
                light_on<=0;
            end
            else 
            begin
            light_on<=light;
            end
        end
    end
endmodule
