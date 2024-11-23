`timescale 1ns / 1ps

module uart_rx(
    input clk,
    input rst,
    input rx,
    
    output rx_sync,
    output [7:0] rx_data,
    output rx_data_ready,
    output frame_error
);
    //parameters
    parameter BAUD_RATE = 115_200;
    parameter CLOCK_RATE = 100_000_000;
    
    //regs
    
    //wires
    wire baud_x16_en;
    
    /*
    module meta_stability_hardener(
        input clk,
        input rst,
        input source_signal,
        output reg hardened_signal
    );
    */
    meta_stability_hardener meta_stability_hardener_inst0(
        .clk(clk),
        .rst(rst),
        .source_signal(rx),
        .hardened_signal(rx_sync)
    );
    
    /*
    module uart_baud_rate_generator(
        input clk,
        input rst,
        output baud_x16_en
    );
    */
    uart_baud_rate_generator#(
        .BAUD_RATE(BAUD_RATE),
        .CLOCK_RATE(CLOCK_RATE)
    ) 
    uart_baud_rate_generator_inst0(
        .clk(clk),
        .rst(rst),
        .baud_x16_en(baud_x16_en)
    );
    
    /*
    module uart_rx_control(
        input clk,
        input rst,
        input baud_x16_en,
        input rx,
        
        output reg [7:0] rx_data,
        output reg rx_data_ready,
        output reg frame_error
    );
    */
    uart_rx_control uart_rx_control_inst0(
        .clk(clk),
        .rst(rst),
        .baud_x16_en(baud_x16_en),
        .rx(rx_sync),
        .rx_data(rx_data),
        .rx_data_ready(rx_data_ready),
        .frame_error(frame_error)
    );
endmodule