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
output reg [3:0] out_data0,  // �����������˿�
output reg [3:0] out_data1,
output reg [3:0] out_data2,
output reg [3:0] out_data3
    );
    
    initial begin
        out_data0 = 16'h3600;  // ��ʼֵ�������� 16'h0000
        out_data1 = 16'h180;
        out_data2 = 16'h60;
        out_data3 = 16'h5;
     end
         localparam data0=4'd10;//Сʱ
         localparam data1=4'd3;//����
         localparam data2=4'd1;//����
         localparam data3=4'd5;//��
         
//    end
     // �� power_on �������ؼ��� reset �ź�
//    always @(posedge clk or posedge set) begin
//            // ��������������ã��� reset ��ʱ��ϣ�����Ĳ���
//            // ���籣��������䣬�����������߼�
//            if(set)begin
//            out_data0 <= in_data0 ;
//            out_data1 <= in_data1 ;
//            out_data2 <= in_data2 ;
//            out_data3 <= in_data3 ; // �� reset Ϊ��ʱ�������������
//            end
//            else begin
//            out_data0 <= out_data0 ;
//            out_data1 <= out_data1 ;
//            out_data2 <= out_data2 ;
//            out_data3 <= out_data3 ;  // ����ʾ�������������
//            end
        
        
//    end
endmodule
