`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 15:46:13
// Design Name: 
// Module Name: countdown_timer
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


module countdown_timer (
    input clk,            // 时钟信号
    input rst,            // 复位信号
    input start,          // 倒计时开始信号
    input [15:0] set_time, // 设定倒计时初始时间（秒）
    output reg [15:0] time_left, // 剩余时间
    output reg done       // 倒计时完成信号
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            time_left <= 16'b0;
            done <= 0;
        end else if (start) begin
            if (time_left > 0)
                time_left <= time_left - 1;
            else
                done <= 1; // 倒计时完成
        end
    end

endmodule

