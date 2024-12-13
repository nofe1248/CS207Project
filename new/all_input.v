`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/03 14:33:54
// Design Name: 
// Module Name: all_input
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

module all_input(
    input clk,clk_100Hz,reset,power_button,             // Ƶ��Ϊ 100Hz,,���ؼ�
    output reg power_on  // ����״̬��� 
);
    localparam COUNT_LIMIT =300;
    reg [8:0] counter;        // ��ʱ�������ڼ�ⳤ��ʱ�䣨����ϵͳʱ��Ϊ1Hz��
    reg stable_button_state;   // �ȶ��İ�ť״̬
    reg last_stable_button_state;
    reg state_meta;
    //ȥ��
    always @(posedge clk ,posedge reset)begin
        if(reset)begin
            stable_button_state<=0;
            last_stable_button_state<=0;
            state_meta<=0;
        end 
        else 
        begin
            if (state_meta==power_button)
            begin
                last_stable_button_state<=stable_button_state;
                stable_button_state<=state_meta;
            end
            else
            begin
                state_meta<=power_button;
            end
        end
    end
    always @(posedge clk ,posedge reset) begin
        if(reset)
        begin
            counter<=0;
            power_on<=0;//Ĭ�Ϲػ�
        end
        else
        begin
            if(last_stable_button_state==0 && stable_button_state==1)//�հ���
            begin
                counter<=0;
            end
            else if(last_stable_button_state==1 && stable_button_state==1)
            begin
                 counter<=counter+1;
            end
            else if(last_stable_button_state==1 && stable_button_state==0)
            begin
                if(counter<COUNT_LIMIT)begin
                    power_on<=1;
                    counter<=0;
                end
                else begin
                    power_on<=0;
                    counter<=0;
                end
            end
        end
    end
endmodule
