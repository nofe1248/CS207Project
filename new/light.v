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
     //����menu���γ�һ���ź�ʹ�ÿ���ʵ��״̬�ĸı�ͻ���,����֮�����һ��Ϊ1���ź�
       reg xinhao;
       reg [8:0] counter;        // ��ʱ�������ڼ�ⳤ��ʱ��
       reg stable_light_state;   // �ȶ��İ�ť״̬
       reg last_stable_light_state;
       reg state_meta;
       //ȥ��
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
                if(last_stable_light_state==0 && stable_light_state==1)//�հ���
                begin
                        counter<=0;
                    xinhao<=0;
                end
                else if(last_stable_light_state==1 && stable_light_state==1)//һֱ����
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
