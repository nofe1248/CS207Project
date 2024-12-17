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
    input clk,            // ʱ���ź�
    input rst,            // ��λ�ź�
    input start,          // ����ʱ��ʼ�ź�
    input [15:0] set_time, // �趨����ʱ��ʼʱ�䣨�룩
    output reg [15:0] time_left, // ʣ��ʱ��
    output reg done       // ����ʱ����ź�
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            time_left <= 16'b0;
            done <= 0;
        end else if (start) begin
            if (time_left > 0)
                time_left <= time_left - 1;
            else
                done <= 1; // ����ʱ���
        end
    end

endmodule

