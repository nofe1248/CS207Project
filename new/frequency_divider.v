`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/06 13:17:13
// Design Name: 
// Module Name: frequency_divider
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


module frequency_divider(
    input clk,reset,             // ����ʱ���ź� (100 MHz)
    output reg clk_out,    // ���ʱ���ź� (1 Hz)
    output reg clk_out2//���
);

    // Ŀ���Ƶֵ��100 MHz -> 1 Hz
    // ��Ҫ��Ƶ 100,000,000
    localparam DIV_VALUE = 100_000_000;  
    localparam DIV_VALUE2 = 500_000;
    reg [26:0] counter;
    reg [19:0] counter2;  
    always @(posedge clk,posedge reset) 
    begin
        if(reset)begin
            counter<=0;
            counter2<=0;
            clk_out<=0;
            clk_out2<=0;
             end
         else
         begin
            if (counter == DIV_VALUE - 1) begin
                counter <= 32'b0;         // ����������
                clk_out <= ~clk_out;      // �л����ʱ��
            end 
            else begin
                counter <= counter + 1;   // ����������
            end
            
            if (counter2 == DIV_VALUE2 - 1) begin
                 counter2 <= 32'b0;         // ����������
                 clk_out2 <= ~clk_out2;      // �л����ʱ��
                 end 
            else begin
                 counter2 <= counter2 + 1;   // ����������
            end
           end
        end
    
endmodule

