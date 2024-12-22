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
    input clk, reset, btn_on_off,                // ʱ���ź�, ,���ػ�����
    input btn_hand1,btn_hand2,//���ƿ���
    
//    input set,// ������������
//    input [3:0] times,//�޸��ڲ�����
     
    input menu,//���Կ����Ƿ���Ե���ģʽ
    input [3:0] btn_mode_smoke,//ģʽ�뵲λ


    input resetchuchang,//��λ�ź�
    input [1:0]set_all_times,//
    input [5:0] btn_time_set,//ʱ�����ü�
    input [5:0] btn_min_set,
    
    input light,
    
//    output button,
    output light_on,// ��������
//    output clk_out,
    output ifoutput,
    output [3:0] state_smoke_lvl,
//    output xinhao1

    output [5:0]cur_hour,[5:0]cur_min,[5:0]cur_second,
    output [5:0]work_hours,[5:0]work_minutes,
    
    output [5:0]hand_time,//���ƿ��ص�ʱ��
    output  remind
);
    wire state;
    //��Ƶ
    wire clk_1Hz;//һ��ġ�Ƶ��
    wire clk_100Hz;
    frequency_divider frequency(
    .clk(clk),
    .reset(reset),
    //���
    .clk_out(clk_1Hz),
    .clk_out2(clk_100Hz)
    );
//    assign clk_out=clk_1Hz;
    //---------------------------------------------------------------------------------
    //���ػ�
    wire power_on;
    all_input inputs(
      .clk_100Hz(clk_100Hz),
      .clk(clk),
      .reset(reset),
      .power_button(btn_on_off),//���ؼ�
      .btn_hand1(btn_hand1),
      .btn_hand2(btn_hand2),
      
      .resetchuchang(resetchuchang),
      .set_all_times(set_all_times),
      .btn_time_set(btn_time_set),
      
      //���
      .power_on(power_on), // ���ػ�״̬���
      
      .hand_time(hand_time)
      );
      assign ifoutput=power_on;
//      assign button=btn_on_off;
      //----------------------------------------------------------------------------
      //ʱ������
//    wire [3:0] initials[3:0];//���ѵ�ʱ�䣬������ʱ�䣬�����ĵ���ʱ�����ػ���ʱ��
//    resets resets(
//    .clk(clk),
//    .set(set),
//    .reset(reset),
//    .times(times),
//    //���
//    .out_data0(initials[0]),
//    .out_data1(initials[1]),
//    .out_data2(initials[2]),
//    .out_data3(initials[3])
//    );
  //----------------------------------------------------------------------------------
  //�ƵĿ���
  light lighton(
    .clk(clk),
    .reset(reset),
    .power_on(power_on),
    .light(light),
    //���
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
        
        //���
        .state(state),// ��ǰ״̬
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
        .btn_time_set( btn_time_set),//ʱ������
        .btn_min_set(btn_min_set),
        
        .state(state),// ��ǰ״̬        
        //���
        .hour(hour),// ��ǰСʱ
        .minute(minute),// ��ǰ����
        .second(second),// ��ǰ����
        
        .work_hours(work_hours),// �ۼƹ���ʱ������λ��Сʱ��
        .work_minutes(work_minutes),//�ۻ���������
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

