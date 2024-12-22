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
input clk,reset,power_on,light,
output reg light_on
    );
     //根据menu来形成一个信号使得可以实现状态的改变和回退,按下之后会有一个为1的信号
       reg xinhao;
       reg [8:0] counter;        // 计时器，用于检测长按时间
       reg stable_light_state;   // 稳定的按钮状态
       reg last_stable_light_state;
       reg state_meta;
       //去抖
       always @(posedge clk ,posedge reset)begin
           if(reset)begin
               stable_light_state<=0;
               last_stable_light_state<=0;
               state_meta<=0;
               xinhao<=0;
           end 
           else 
           begin
               if (state_meta==light)
               begin
                   last_stable_light_state<=stable_light_state;
                   stable_light_state<=state_meta;
               end
               else
               begin
                   state_meta<=light;
               end
           end
       end
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
                if(last_stable_light_state==0 && stable_light_state==1)//刚按下
                begin
                        counter<=0;
                    xinhao<=0;
                end
                else if(last_stable_light_state==1 && stable_light_state==1)//一直按着
                begin
                    counter<=counter+1;
                end
                else if(last_stable_light_state==1 && stable_light_state==0)
                begin
                    if(counter>0)begin
                        xinhao<=1;
                        counter<=0;
                    end
                end
                    if(xinhao)begin
                        light_on<=~light_on;
                        xinhao<=0;
                    end
            end
        end
    end
   
endmodule
