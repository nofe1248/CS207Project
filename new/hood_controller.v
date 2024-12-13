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
    input clk,clk_100Hz,reset,power_on,// 时钟信号100MHz，短时间信号100Hz,菜单信号,返回信号，开机信号
    
    input [15:0]CLEANING_DELAY,
    
    input menu,
    input [3:0] btn_mode_smoke,//模式与挡位
        
    output reg [1:0] state,     // 当前状态
    output reg [3:0] state_smoke_lvl,
    
    output xinhao1

);
    //根据menu来形成一个信号使得可以实现状态的改变和回退,按下之后会有一个为1的信号
    reg xinhao;
    reg [8:0] counter;        // 计时器，用于检测长按时间
    reg stable_menu_state;   // 稳定的按钮状态
    reg last_stable_menu_state;
    reg state_meta;
    //去抖
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
    //状态定义
    localparam OFF      = 4'b0000;
    localparam STANDBY  = 4'b1111;
    localparam SMOKING_lvl1  = 4'b0001;
    localparam SMOKING_lvl2  = 4'b0010;
    localparam SMOKING_lvl3  = 4'b0100;
    localparam CLEANING = 4'b1000;
    // 状态定义
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
            if(last_stable_menu_state==0 && stable_menu_state==1)//刚按下
            begin
                counter<=0;
                xinhao<=0;
            end
            else if(last_stable_menu_state==1 && stable_menu_state==1)//一直按着
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
            else//稳定时
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
    
        // 自清洁完成
    always @(posedge clk_100Hz , posedge reset) begin
        if(reset)begin
             cleaning_done <= 0;           // 退出清洁模式时清洁完成标志为0
             cleaning_timer <= 0;          // 重置计时器
        end
        else
        begin
            if (state == CLEANING) begin
                if (cleaning_timer < CLEANING_DELAY) begin
                    cleaning_timer <= cleaning_timer + 1;  // 计时
                    cleaning_done <= 0;       // 清洁未完成
                 end else begin
                     cleaning_done <= 1;       // 达到延迟后，清洁完成
                     
                 end
            end else begin
                cleaning_done <= 0;           // 退出清洁模式时清洁完成标志为0
                cleaning_timer <= 0;          // 重置计时器
            end
        end
    end
endmodule

