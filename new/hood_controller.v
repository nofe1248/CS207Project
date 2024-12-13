`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 15:44:30
// Design Name: 
// Module Name: hood_controller
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
module hood_controller (
    input clk,clk_100Hz,reset,power_on,// ʱ���ź�100MHz����ʱ���ź�100Hz,�˵��ź�,�����źţ������ź�
    
    input [15:0]CLEANING_DELAY,
    
    input menu,
    input [3:0] btn_mode_smoke,//ģʽ�뵲λ
        
    output reg [1:0] state,     // ��ǰ״̬
    output reg [3:0] state_smoke_lvl,
    
    output xinhao1

);
    //����menu���γ�һ���ź�ʹ�ÿ���ʵ��״̬�ĸı�ͻ���,����֮�����һ��Ϊ1���ź�
    reg xinhao;
    reg [8:0] counter;        // ��ʱ�������ڼ�ⳤ��ʱ��
    reg stable_menu_state;   // �ȶ��İ�ť״̬
    reg last_stable_menu_state;
    reg state_meta;
    //ȥ��
    always @(posedge clk_100Hz ,posedge reset)begin
        if(reset)begin
            stable_menu_state<=0;
            last_stable_menu_state<=0;
            state_meta<=0;
        end 
        else 
        begin
            if (state_meta==menu)
            begin
                last_stable_menu_state<=stable_menu_state;
                stable_menu_state<=state_meta;
            end
            else
            begin
                state_meta<=menu;
            end
        end
    end
    //״̬����
    localparam OFF      = 4'b0000;
    localparam STANDBY  = 4'b1111;
    localparam SMOKING_lvl1  = 4'b0001;
    localparam SMOKING_lvl2  = 4'b0010;
    localparam SMOKING_lvl3  = 4'b0100;
    localparam CLEANING = 4'b1000;
    // ״̬����
    localparam OFF1      = 2'b00;
    localparam STANDBY1  = 2'b01;
    localparam SMOKING1  = 2'b10;
    localparam CLEANING1 = 2'b11;
    reg [15:0]cleaning_timer;
    reg cleaning_done;
    always @(posedge clk ,posedge reset) begin
        if(reset)
        begin
            counter<=0;
            xinhao<=0;state_smoke_lvl<=OFF;state<=OFF1;
        end
        else
        begin
            if(last_stable_menu_state==0 && stable_menu_state==1)//�հ���
            begin
                counter<=0;
                xinhao<=0;
            end
            else if(last_stable_menu_state==1 && stable_menu_state==1)//һֱ����
            begin
                counter<=counter+1;
            end
            else if(last_stable_menu_state==1 && stable_menu_state==0)
            begin
                if(counter>0)begin
                    xinhao<=1;
                end
                else begin
                    xinhao<=0;
                end
            end
            else//�ȶ�ʱ
            begin
                    if(power_on)begin
                            if(state_smoke_lvl==OFF)begin
                                state_smoke_lvl<=STANDBY;state<=STANDBY1;
                            end
                            if(xinhao)begin
                                if(state_smoke_lvl==STANDBY)begin
                                    case(btn_mode_smoke)
                                        SMOKING_lvl1:begin
                                            state_smoke_lvl<=SMOKING_lvl1;state<=SMOKING1;
                                            xinhao<=0;
                                        end
                                        SMOKING_lvl2:begin
                                            state_smoke_lvl<=SMOKING_lvl2;state<=SMOKING1;
                                            xinhao<=0;
                                        end
                                        SMOKING_lvl3:begin
                                            state_smoke_lvl<=SMOKING_lvl3;state<=SMOKING1;
                                            xinhao<=0;
                                        end
                                        CLEANING:begin
                                            state_smoke_lvl<=CLEANING;state<=CLEANING1;
                                            xinhao<=0;
                                        end
                                    endcase
                                end
                                else if(state_smoke_lvl==CLEANING)begin
                                    if(cleaning_done)begin
                                        state_smoke_lvl<=STANDBY;state<=STANDBY;
                                    end
                                    xinhao<=0;
                                end
                                else
                                begin
                                    state_smoke_lvl<=STANDBY;state<=STANDBY;
                                    xinhao<=0;
                                end
                            end
                        end
                        else
                        begin
                            state_smoke_lvl<=OFF;state<=OFF1;
                        end
            end
        end
    end
    
    assign xinhao1=xinhao;
        
    
//    always @(posedge clk , posedge reset) begin
//        xinhao_meta<=xinhao;
//        if(reset)begin
//            state_smoke_lvl<=OFF;state<=OFF1;
//        end
//        else begin
//            if(power_on)begin
//                if(state_smoke_lvl==OFF)begin
//                    state_smoke_lvl<=STANDBY;state<=STANDBY1;
//                end
//                if(xinhao && xinhao_meta)begin
//                    if(state_smoke_lvl==STANDBY)begin
//                        case(btn_mode_smoke)
//                            SMOKING_lvl1:begin
//                                state_smoke_lvl<=SMOKING_lvl1;state<=SMOKING1;
//                                xinhao_meta<=0;
//                            end
//                            SMOKING_lvl2:begin
//                                state_smoke_lvl<=SMOKING_lvl2;state<=SMOKING1;
//                                xinhao_meta<=0;
//                            end
//                            SMOKING_lvl3:begin
//                                state_smoke_lvl<=SMOKING_lvl3;state<=SMOKING1;
//                                xinhao_meta<=0;
//                            end
//                            CLEANING:begin
//                                state_smoke_lvl<=CLEANING;state<=CLEANING1;
//                                xinhao_meta<=0;
//                            end
//                        endcase
//                    end
//                    else if(state_smoke_lvl==CLEANING)begin
//                        if(cleaning_done)begin
//                            state_smoke_lvl<=STANDBY;state<=STANDBY;
//                        end
//                        xinhao_meta<=0;
//                    end
//                    else
//                    begin
//                        state_smoke_lvl<=STANDBY;state<=STANDBY;
//                        xinhao_meta<=0;
//                    end
//                end
//            end
//            else
//            begin
//                state_smoke_lvl<=OFF;state<=OFF1;
//            end
//        end
//    end
    
        // ��������
    always @(posedge clk_100Hz , posedge reset) begin
        if(reset)begin
             cleaning_done <= 0;           // �˳����ģʽʱ�����ɱ�־Ϊ0
             cleaning_timer <= 0;          // ���ü�ʱ��
        end
        else
        begin
            if (state == CLEANING) begin
                if (cleaning_timer < CLEANING_DELAY) begin
                    cleaning_timer <= cleaning_timer + 1;  // ��ʱ
                    cleaning_done <= 0;       // ���δ���
                 end else begin
                     cleaning_done <= 1;       // �ﵽ�ӳٺ�������
                     
                 end
            end else begin
                cleaning_done <= 0;           // �˳����ģʽʱ�����ɱ�־Ϊ0
                cleaning_timer <= 0;          // ���ü�ʱ��
            end
        end
    end
endmodule

