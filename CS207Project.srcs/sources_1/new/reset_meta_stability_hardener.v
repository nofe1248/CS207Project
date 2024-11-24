`timescale 1ns / 1ps

//meta stability hardener that synchronize asynchronous
//reset signal to the given clock

module reset_meta_stability_hardener(
    input clk,
    input async_rst,
    output reg sync_rst
);
    //regs
    reg rst_meta;
    
    //body
    always @(posedge clk or posedge async_rst)
    begin
        if (async_rst)
        begin
            rst_meta <= 1'b1;
            sync_rst <= 1'b1;
        end
        else
        begin
            rst_meta <= 1'b0;
            sync_rst <= rst_meta;
        end
    end
endmodule
