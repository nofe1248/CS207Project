`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/12 20:18:39
// Design Name: 
// Module Name: times
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


module times(
    input clk,clk_100Hz,reset,power_on,
    
    input [1:0]set_all_times,[5:0]btn_time_set,[5:0]btn_min_set,//ʱ������
    input [1:0]state,
    
    output reg [5:0] hour,reg [5:0] minute,reg[5:0]second,
    output reg [5:0] work_hours,reg[5:0]work_minutes,// �ۼƹ���ʱ������λ��Сʱ��
    output reg remind
    );
        // ��ʱ���͹���ʱ��
//            reg[5:0]second;
            reg [6:0] time_counter;    // �������ʱ
           
    // ʱ����ʾ�����߼�
    always @(posedge clk_100Hz , posedge reset) begin
        if(reset)begin
            time_counter<=0;
            hour<=0;
            minute<=0;
            second<=0;
        end
        else begin
            if (power_on==1) begin
                if(set_all_times==2'b00)begin
                    
                        time_counter <= time_counter + 1;  // ÿ���Ӽ�ʱ
                        // ÿ���Ӹ����롢���ӡ�Сʱ
                        if (time_counter == 7'd100) begin
                            second <= second + 1;
                            time_counter <= 0;
                        end
                        if (second == 60) begin
                            second <= 0;
                            minute <= minute + 1;
                        end
                        if (minute == 60) begin
                            minute <= 0;
                            hour <= hour + 1;
                        end
                    
                end
                else if(set_all_times==2'b01)begin
                    hour<=btn_time_set;
                    minute<=btn_min_set;
                end
            end
            else begin
            time_counter<=0;
            hour<=0;
            minute<=0;
            second<=0;
            end
        end
    end 
    reg [6:0] work_time_counter; // �����̹���ʱ������λ���룩
    reg [5:0] remind_time_hour;
    reg [5:0] work_second;
    // �����̹���ʱ��ͳ������������
    always @(posedge clk_100Hz , posedge reset) begin
        if(reset)begin
            work_time_counter<=0;
            work_hours<=0;
            work_minutes<=0;
            work_second<=0;
            remind_time_hour<=10;
            remind <= 0;
        end
        else
        begin
            if (power_on==1) begin
               
                if(set_all_times==2'b10)begin
                    remind_time_hour=btn_time_set;
                end
                else
                begin
                        if (state == 2'b01) begin
                            work_time_counter<= work_time_counter + 1;  // ÿ���Ӽ�ʱ
                           if (work_time_counter == 100) begin
                                work_second <= work_second + 1;
                                work_time_counter<= 0;
                           end
                           
                           if (work_second == 60) begin
                                work_second <= 0;
                                work_minutes <= work_minutes + 1;
                           end
                           if (work_minutes == 60) begin
                                work_minutes <= 0;
                                work_hours <= work_hours + 1;
                           end
                            if (work_hours >=  remind_time_hour) begin  //�ﵽ�涨��ʱ��
                                    remind<=1;
                            end
                        end
                        else if (state == 2'b11) begin
                            work_time_counter <= 0;  // ����������
                            work_second <= 0;
                            work_minutes <= 0;
                            work_hours<=0;
                            remind <= 0;  // �������
                                    
                        end 
                end
             end
             else begin
              work_time_counter<=0;
              work_hours<=0;
              work_minutes<=0;
              work_second<=0;
              remind <= 0;
             end
        end
    end
endmodule
