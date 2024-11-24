`timescale 1ns / 1ps

//a simple clock divider

module clock_divider(
    input clk_tx,
    input rst_clk_tx,
    input [15:0] pre_clk_tx,
    output reg en_clk_samp
);
    //regs
    reg [15:0] cnt;
    
    //body
    always @(posedge clk_tx)
    begin
        if (rst_clk_tx)
        begin
            en_clk_samp <= #5 1'b1;
            cnt <= 16'b0;
        end
        else
        begin
            en_clk_samp <= #5 (cnt == 16'b1);
            
            if (cnt == 0)
            begin
                cnt <= pre_clk_tx - 1'b1;
            end
            else
            begin
                cnt <= cnt - 1'b1;
            end
        end
    end
endmodule
