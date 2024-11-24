`timescale 1ns / 1ps

module extractor_controller(
    input clk_pin,
    input rst_pin,
    
    input rxd_pin,
    output txd_pin,
    
    input [7:0] sw_pin,
    
    output bt_pw_on,
    output bt_master_slave,
    output bt_sw_hw,
    output bt_rst_n,
    output bt_sw,
    
    output [15:0] leds_pin
);
    //=====parameters=====
    parameter BAUD_RATE = 9600;

    parameter CLOCK_RATE_RX = 100_000_000;
    parameter CLOCK_RATE_TX = 100_000_000; 

    //=====wires=====
    wire rst_i;
    wire rxd_i;
    wire txd_o;
    wire [15:0] led_o;
    //clocks from clock generator
    wire clk_rx;
    wire clk_tx;
    
    //synchronized reset from reset generator
    wire rst_clk_rx;
    wire rst_clk_tx;
    
    //from RS232 receiver
    wire rxd_clk_rx;
    wire rx_data_ready;
    wire [7:0] rx_data; 
    
    //body
    
    //I/O buffer
    IBUF IBUF_rst_inst0(.I(rst_pin), .O(rst_i));
    IBUF IBUF_rxd_inst0(.I(rxd_pin), .O(rxd_i));
    
    OBUF OBUF_txd_inst0(.I(txd_o), .O(txd_pin));
    OBUF OBUF_led_inst0(.I(led_o[0]), .O(leds_pin[0]));
    OBUF OBUF_led_inst1(.I(led_o[1]), .O(leds_pin[1]));
    OBUF OBUF_led_inst2(.I(led_o[2]), .O(leds_pin[2]));
    OBUF OBUF_led_inst3(.I(led_o[3]), .O(leds_pin[3]));
    OBUF OBUF_led_inst4(.I(led_o[4]), .O(leds_pin[4]));
    OBUF OBUF_led_inst5(.I(led_o[5]), .O(leds_pin[5]));
    OBUF OBUF_led_inst6(.I(led_o[6]), .O(leds_pin[6]));
    OBUF OBUF_led_inst7(.I(led_o[7]), .O(leds_pin[7]));
    OBUF OBUF_led_inst8(.I(led_o[8]), .O(leds_pin[8]));
    OBUF OBUF_led_inst9(.I(led_o[9]), .O(leds_pin[9]));
    OBUF OBUF_led_inst10(.I(led_o[10]), .O(leds_pin[10]));
    OBUF OBUF_led_inst11(.I(led_o[11]), .O(leds_pin[11]));
    OBUF OBUF_led_inst12(.I(led_o[12]), .O(leds_pin[12]));
    OBUF OBUF_led_inst13(.I(led_o[13]), .O(leds_pin[13]));
    OBUF OBUF_led_inst14(.I(led_o[14]), .O(leds_pin[14]));
    OBUF OBUF_led_inst15(.I(led_o[15]), .O(leds_pin[15]));
    
    // clock generator
    /*
    module clock_generator(
        input clk,
        input rst_i,
        input rst_clk_tx,
        input [15:0] pre_clk_tx,
        
        output clk_rx,
        output clk_tx,
        output clk_samp,
        output en_clk_samp,
        output clock_locked
    );
    */
    clock_generator clock_generator_inst0(
        .clk(clk_pin),
        .rst_i(rst_i),
        .rst_clk_tx(rst_clk_tx),
        .pre_clk_tx(),
        .clk_rx(clk_rx),
        .clk_tx(clk_tx),
        .clk_samp(),
        .en_clk_samp(),
        .clock_locked(clock_locked)
    );
    
    //reset generator
    /*
    module reset_generator(
        input clk_rx,
        input clk_tx,
        input clk_samp,
        input rst_i,
        input clock_locked,
        
        output rst_clk_rx,
        output rst_clk_tx,
        output rst_clk_samp
    );
    */
    reset_generator reset_generator_inst0(
        .clk_rx(clk_rx),
        .clk_tx(clk_tx),
        .clk_samp(),
        .rst_i(rst_i),
        .clock_locked(clock_locked),
        .rst_clk_rx(rst_clk_rx),
        .rst_clk_tx(rst_clk_tx),
        .rst_clk_samp()
    );
    
    //UART receiver
    /*
    module uart_rx(
        input clk,
        input rst,
        input rx,
        
        output rx_sync,
        output [7:0] rx_data,
        output rx_data_ready,
        output frame_error
    );
    */
    uart_rx#(
        .BAUD_RATE(BAUD_RATE),
        .CLOCK_RATE(CLOCK_RATE_RX)
    ) 
    uart_rx_inst0(
        .clk(clk_rx),
        .rst(rst_clk_rx),
        .rx(rxd_i),
        .rx_sync(rxd_clk_rx),
        .rx_data_ready(rx_data_ready),
        .rx_data(rx_data),
        .frame_error()
    );
    
    assign led_o[7:0] = rx_data;
    assign led_o[8] = rx_data_ready;
    assign led_o[9] = !rx_data_ready;
    
    assign bt_master_slave = sw_pin[0];
    assign bt_sw_hw = sw_pin[1];
    assign bt_rst_n = sw_pin[2];
    assign bt_sw = sw_pin[3];
    assign bt_pw_on = sw_pin[4];
endmodule
