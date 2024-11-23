`timescale 1ns / 1ps

//a baud rate generator that generates a 16x baud enable

module uart_baud_rate_generator(
    input clk,
    input rst,
    output baud_x16_en
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
    
    //parameters and local parameters:
    parameter BAUD_RATE = 57_600;
    parameter CLOCK_RATE = 100_000_000;
    
    localparam OVERSAMPLE_RATE = BAUD_RATE * 16;
    localparam DIVIDER = (CLOCK_RATE + OVERSAMPLE_RATE / 2) / OVERSAMPLE_RATE;
    localparam OVERSAMPLE_VALUE = DIVIDER - 1;
    localparam CNT_WIDTH = ceil_log2(DIVIDER);
    
    //registers
    reg [CNT_WIDTH-1:0] internal_cnt;
    reg baud_x16_en_reg;
    
    //wires
    wire [CNT_WIDTH-1:0] internal_cnt_minus_1;
    
    //body
    always @(posedge clk)
    begin
        if (rst)
        begin
            internal_cnt <= OVERSAMPLE_VALUE;
            baud_x16_en_reg <= 1'b0;
        end
        else
        begin
            baud_x16_en_reg <= (internal_cnt_minus_1 == {CNT_WIDTH{1'b0}});
            
            if (internal_cnt == {CNT_WIDTH{1'b0}})
            begin
                internal_cnt <= OVERSAMPLE_VALUE;
            end
            else
            begin
                internal_cnt <= internal_cnt_minus_1;
            end
        end
    end
    
    assign baud_x16_en = baud_x16_en_reg;
endmodule