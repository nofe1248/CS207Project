`timescale 1ns / 1ps

//generate clocks

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
    clock_divider clock_divider_inst0(
        .clk_tx(clk_tx),
        .rst_clk_tx(rst_clk_tx),
        .pre_clk_tx(pre_clk_tx),
        .en_clk_samp(en_clk_samp)
    );

    clk_core clk_core_inst0(
        .clk_in1(clk),
        .clk_out1(clk_rx),
        .clk_out2(clk_tx),
        .reset(rst_i),
        .locked(clock_locked)
    );
    
    BUFHCE#(
        .INIT_OUT(0)
    )
    BUFHCE_clk_samp_inst0(
        .O(clk_samp),
        .CE(en_clk_samp),
        .I(clk_tx)
    );
endmodule
