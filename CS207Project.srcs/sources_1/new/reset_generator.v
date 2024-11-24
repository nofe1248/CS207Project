`timescale 1ns / 1ps

//generate reset signals

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
    //wires
    wire int_rst;
    
    //body
    assign int_rst = rst_i || !clock_locked;
    
    /*
    module reset_meta_stability_hardener(
        input clk,
        input async_rst,
        output reg sync_rst
    );
    */
    
    //for clk_rx
    reset_meta_stability_hardener reset_meta_stability_hardener_inst0(
        .clk(clk_rx),
        .async_rst(int_rst),
        .sync_rst(rst_clk_rx)
    );
    
    //for clk_tx
    reset_meta_stability_hardener reset_meta_stability_hardener_inst1(
        .clk(clk_tx),
        .async_rst(int_rst),
        .sync_rst(rst_clk_tx)
    );
    
    //for clk_samp
    reset_meta_stability_hardener reset_meta_stability_hardener_inst2(
        .clk(clk_samp),
        .async_rst(int_rst),
        .sync_rst(rst_clk_samp)
    );
endmodule
