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
    
    input [1:0]set_all_times,[5:0]btn_time_set,//ʱ������
    input [1:0]state,
    output reg [5:0] hour,reg [5:0] minute,reg [5:0] second,
    output reg [5:0] work_hours,reg remind// �ۼƹ���ʱ������λ��Сʱ��
    );
        // ��ʱ���͹���ʱ��
            reg [6:0] time_counter;    // �������ʱ
            reg [15:0] work_time_counter; // �����̹���ʱ������λ���룩
    // ʱ����ʾ�����߼�
    always @(posedge clk_100Hz , posedge reset) begin
        if(reset)begin
            time_counter<=0;
            hour<=0;
            minute<=0;
            second<=0;
        end
        else begin
            if(set_all_times==2'b00)begin
                if (power_on==1) begin
                    time_counter <= time_counter + 1;  // ÿ���Ӽ�ʱ
                    // ÿ���Ӹ����롢���ӡ�Сʱ
                    if (time_counter == 100) begin
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
            end
            else if(set_all_times==2'b01)begin
                second<=btn_time_set;
            end
            else if(set_all_times==2'b10)begin
                minute<=btn_time_set;
            end 
            else if(set_all_times==2'b11)begin
                hour<=btn_time_set;
            end
        end
    end
            
    // �����̹���ʱ��ͳ������������
    always @(posedge clk_100Hz , posedge reset) begin
        if(reset)begin
            work_time_counter<=0;
            work_hours<=0;
        end
        else
        begin
            if (state == 2'b01) begin
                work_time_counter <= work_time_counter + 1;  // �ۼ�����
                if (work_time_counter >= 360000) begin  // �ﵽ10Сʱ��36000�룩
                    work_hours<=work_hours+1;
                    if(work_hours==6'd10)begin
                        remind<=1;
                    end
                end
            end else if (state == 2'b11) begin
                work_time_counter <= 0;  // ����������
                work_hours<=0;
                remind <= 0;  // �������
                            
            end 
        end
    end
endmodule
