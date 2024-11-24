`timescale 1ns / 1ps

module signal_debouncer(
    input clk,
    input rst,
    input source_signal,
    output debounced_signal
);
    //calculate the ceiling of log2 of n
    function integer ceil_log2;
        input [31:0] n;
        
        reg [31:0] temp;
        begin
            temp = n - 1;
            for (ceil_log2 = 0; temp > 0; ceil_log2 = ceil_log2 + 1)
                temp = temp >> 1;
        end
    endfunction 
    
    //parameters and local parameters
    parameter FILTER = 200_000_000;
    
    localparam RELOAD = FILTER - 1;
    localparam FILTER_WIDTH = ceil_log2(FILTER);
    
    //regs
    reg signal_out_reg;
    reg [FILTER_WIDTH - 1:0] cnt;
    
    //wires
    wire signal_in_clk;
    
    //body
    /*
    module meta_stability_hardener(
        input clk,
        input rst,
        input source_signal,
        output reg hardened_signal
    );
    */
    //reuse meta_stability_hardener
    meta_stability_hardener meta_stability_hardener_inst0(
        .clk(clk),
        .rst(rst),
        .source_signal(source_signal),
        .hardened_signal(signal_in_clk)
    );
    
    always @(posedge clk)
    begin
        if (rst)
        begin
            signal_out_reg <= signal_in_clk;
            cnt <= RELOAD;
        end
        else
        begin
            if (signal_in_clk == signal_out_reg)
            begin
                cnt <= RELOAD;
            end
            else if (cnt == 0)
            begin
                signal_out_reg <= signal_in_clk;
                cnt <= RELOAD;
            end
            else
            begin
                cnt <= cnt - 1'b1;
            end
        end
    end
    
    assign debounced_signal = signal_out_reg;
endmodule
