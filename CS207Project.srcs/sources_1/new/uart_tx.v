`timescale 1ns / 1ps

module uart_tx(
    input clk,
    input rst,
    input char_fifo_empty,
    input [7:0] char_fifo_doutm
    
    output char_fifo_rd_en,
    output tx
);
    //parameters
    parameter BAUD_RATE = 57_600;
    parameter CLOCK_RATE = 100_000_000;
    
    //regs
    
    //wires
    wire baud_x16_en;
    
    //body
    
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
    module uart_tx_control(
        input clk,
        input rst,
        input baud_x16_en,
        input char_fifo_empty,
        input [7:0] char_fifo_dout,
        
        output char_fifo_rd_en,
        output reg tx
    );
    */
    uart_tx_control uart_tx_control_inst0(
        .clk(clk),
        .rst(rst),
        .baud_x16_en(baud_x16_en),
        .char_fifo_empty(char_fifo_empty),
        .char_fifo_dout(char_fifo_dout),
        .char_fifo_rd_en(char_fifo_rd_en),
        .tx(tx)
    );
endmodule
