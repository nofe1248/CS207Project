`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 15:50:33
// Design Name: 
// Module Name: hood_top1
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
module hood_top1 (
    input clk, reset, btn_on_off,                // 时钟信号, ,开关机按键
    input btn_hand1,btn_hand2,//手势开关
    
//    input set,// 调整出场设置
//    input [3:0] times,//修改内部设置
     
    input menu,//可以控制是否可以调控模式
    input [3:0] btn_mode_smoke,//模式与挡位


    input resetchuchang,//复位信号
    input [1:0]set_all_times,//
    input [5:0] btn_time_set,//时间设置键
    input [5:0] btn_min_set,
    
    input light,
    
//    output button,
    output light_on,// 照明功能
//    output clk_out,
    output ifoutput,
    output [3:0] state_smoke_lvl,
//    output xinhao1

    output [5:0]cur_hour,[5:0]cur_min,[5:0]cur_second,
    output [5:0]work_hours,[5:0]work_minutes,
    
    output [5:0]hand_time,//手势开关的时间
    output  remind
);
    wire state;
    //分频
    wire clk_1Hz;//一秒的·频率
    wire clk_100Hz;
    frequency_divider frequency(
    .clk(clk),
    .reset(reset),
    //输出
    .clk_out(clk_1Hz),
    .clk_out2(clk_100Hz)
    );
//    assign clk_out=clk_1Hz;
    //---------------------------------------------------------------------------------
    //开关机
    wire power_on;
    all_input inputs(
      .clk_100Hz(clk_100Hz),
      .clk(clk),
      .reset(reset),
      .power_button(btn_on_off),//开关键
      .btn_hand1(btn_hand1),
      .btn_hand2(btn_hand2),
      
      .resetchuchang(resetchuchang),
      .set_all_times(set_all_times),
      .btn_time_set(btn_time_set),
      
      //输出
      .power_on(power_on), // 开关机状态输出
      
      .hand_time(hand_time)
      );
      assign ifoutput=power_on;
//      assign button=btn_on_off;
      //----------------------------------------------------------------------------
      //时间设置
//    wire [3:0] initials[3:0];//提醒的时间，自清洁的时间，三档的倒计时，开关机的时间
//    resets resets(
//    .clk(clk),
//    .set(set),
//    .reset(reset),
//    .times(times),
//    //输出
//    .out_data0(initials[0]),
//    .out_data1(initials[1]),
//    .out_data2(initials[2]),
//    .out_data3(initials[3])
//    );
  //----------------------------------------------------------------------------------
  //灯的开关
  light lighton(
    .clk(clk),
    .reset(reset),
    .power_on(power_on),
    .light(light),
    //输出
    .light_on(light_on)
  );
  //----------------------------------------------------------------------------------
    wire [5:0] hour;
    wire [5:0] minute;
    wire [5:0] second;
//    wire [15:0] work_hours;
    
    hood_controller controller (
        .clk(clk),
        .clk_100Hz(clk_100Hz),
        .reset(reset),
        .menu(menu),
        .power_on(power_on),
//        .CLEANING_DELAY(initials[1]),
        
        .btn_mode_smoke(btn_mode_smoke),
        
        //输出
        .state(state),// 当前状态
        .state_smoke_lvl(state_smoke_lvl)
//        .xinhao1(xinhao1)
    );
//-----------------------------------------------------------------------------------------
    times all_times(
        .clk(clk),
        .clk_100Hz(clk_100Hz),
        .reset(reset),
        .power_on(power_on),
        .resetchuchang(resetchuchang),
        
        .set_all_times(set_all_times),
        .btn_time_set( btn_time_set),//时间设置
        .btn_min_set(btn_min_set),
        
        .state(state),// 当前状态        
        //输出
        .hour(hour),// 当前小时
        .minute(minute),// 当前分钟
        .second(second),// 当前秒数
        
        .work_hours(work_hours),// 累计工作时长（单位：小时）
        .work_minutes(work_minutes),//累积工作分钟
        .remind(remind)        
    );
    assign cur_hour=hour;
    assign cur_min=minute;
    assign cur_second=second;
//-----------------------------------------------------------------------------------------
    all_output outputs(
    .power_on(power_on)
    );
endmodule

