`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/05 23:25:16
// Design Name: 
// Module Name: reset
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


module resets(
input clk,
input reset,
input set,
input [3:0]times,
output reg [3:0] out_data0,  // 定义多个独立端口
output reg [3:0] out_data1,
output reg [3:0] out_data2,
output reg [3:0] out_data3
    );
    
    initial begin
        out_data0 = 16'h3600;  // 初始值，假设是 16'h0000
        out_data1 = 16'h180;
        out_data2 = 16'h60;
        out_data3 = 16'h5;
     end
         localparam data0=4'd10;//小时
         localparam data1=4'd3;//分钟
         localparam data2=4'd1;//分钟
         localparam data3=4'd5;//秒
         
//    end
     // 在 power_on 的上升沿激活 reset 信号
//    always @(posedge clk or posedge set) begin
//            // 这里根据需求设置，在 reset 低时你希望做的操作
//            // 比如保持输出不变，或者是其他逻辑
//            if(set)begin
//            out_data0 <= in_data0 ;
//            out_data1 <= in_data1 ;
//            out_data2 <= in_data2 ;
//            out_data3 <= in_data3 ; // 当 reset 为高时，输出跟随输入
//            end
//            else begin
//            out_data0 <= out_data0 ;
//            out_data1 <= out_data1 ;
//            out_data2 <= out_data2 ;
//            out_data3 <= out_data3 ;  // 这里示例保持输出不变
//            end
        
        
//    end
endmodule
