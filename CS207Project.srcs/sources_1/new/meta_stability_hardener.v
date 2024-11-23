`timescale 1ns / 1ps

//a simple signal hardener

module meta_stability_hardener(
    input clk,
    input rst,
    input source_signal,
    output reg hardened_signal
);
    reg meta_signal;
    
    always @(posedge clk)
    begin
        if (rst)
        begin
            meta_signal <= 1'b0;
            hardened_signal <= 1'b0; 
        end
        else
        begin
            meta_signal <= source_signal;
            hardened_signal <= meta_signal;
        end
    end
endmodule