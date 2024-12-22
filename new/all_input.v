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
    input btn_hand1,btn_hand2,//���ƿ���
    input resetchuchang,[1:0]set_all_times,[5:0]btn_time_set,
    output reg power_on,  // ����״̬��� 
    output reg [5:0]hand_time//���ƿ��ص�ʱ��
);
    localparam COUNT_LIMIT =300;
    reg [8:0] counter;        // ��ʱ�������ڼ�ⳤ��ʱ�䣨����ϵͳʱ��Ϊ1Hz��
    reg stable_button_state,stable_btn_hand1,stable_btn_hand2;   // �ȶ��İ�ť״̬
    reg last_stable_button_state,last_stable_btn_hand1,last_stable_btn_hand2;//�ϸ�ʱ��״̬
    reg state_meta,stable_btn_hand1_meta,stable_btn_hand2_meta;
    //ȥ��
    always @(posedge clk ,posedge reset)begin
        if(reset)begin
            stable_button_state<=0;stable_btn_hand1<=0;stable_btn_hand2<=0;
            last_stable_button_state<=0;last_stable_btn_hand1<=0;last_stable_btn_hand2<=0;
            state_meta<=0;stable_btn_hand1_meta<=0;stable_btn_hand2_meta<=0;
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
            if (stable_btn_hand1_meta==btn_hand1)
            begin
                last_stable_btn_hand1<=stable_btn_hand1;
                stable_btn_hand1<=stable_btn_hand1_meta;
            end
            else
            begin
                stable_btn_hand1_meta<=btn_hand1;
            end
            if (stable_btn_hand2_meta==btn_hand2)
            begin
                last_stable_btn_hand2<=stable_btn_hand2;
                stable_btn_hand2<=stable_btn_hand2_meta;
            end
            else
            begin
                stable_btn_hand2_meta<=btn_hand2;
            end
        end
    end
    reg ifopen;
    reg [6:0]count;
    reg[5:0]second;
    always @(posedge clk_100Hz ,posedge reset) begin
        if(reset)
        begin
            counter<=0;
            power_on<=0;//Ĭ�Ϲػ�
            hand_time<=5'd5;
            ifopen<=0;
            count<=0;
            second<=0;
        end
        else
        begin
            if(set_all_times==2'b11)begin
                hand_time<=btn_time_set;
            end
            if(resetchuchang)begin
                hand_time<=5'd5;
            end
          
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
            
            if(btn_hand1)begin
                ifopen<=1;
            end
            if(ifopen)begin
                count<=count+1;
                if(count==100)begin
                    second<=second+1;
                    if(second==hand_time)begin
                        ifopen<=0;
                        count<=0;
                        second<=0;
                    end
                end
            end
            if(btn_hand2 && ifopen)begin
                power_on<=1;
                ifopen<=0;
            end
            
        end
    end
endmodule
