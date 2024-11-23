`timescale 1ns / 1ps

module uart_tx_control(
    input clk,
    input rst,
    input baud_x16_en,
    input char_fifo_empty,
    input [7:0] char_fifo_dout,
    
    output char_fifo_rd_en,
    output reg tx
);
    //parameters and local parameters
    //states
    localparam
        IDLE = 2'b00,
        START = 2'b01,
        DATA = 2'b10,
        STOP = 2'b11;
        
    //regs
    reg [1:0] state;
    reg [3:0] over_sample_cnt;
    reg [2:0] bit_cnt;
    reg char_fifo_pop;
    
    //wires
    wire over_sample_cnt_done;
    wire bit_cnt_done;
    
    //body
    
    //main fsm
    always @(posedge clk)
    begin
        if (rst)
        begin
            state <= IDLE;
            char_fifo_pop <= 1'b0;
        end
        else
        begin
            if (baud_x16_en)
            begin
                char_fifo_pop <= 1'b0;
                case (state)
                    IDLE:
                    begin
                        if (!char_fifo_empty)
                        begin
                            state <= START;
                        end //if (!char_fifo_empty)
                    end //case IDLE
                    
                    START:
                    begin
                        if (over_sample_cnt_done)
                        begin
                            state <= DATA;
                        end //if (over_sample_cnt_done)
                    end //case START
                    
                    DATA:
                    begin
                        if (over_sample_cnt_done && bit_cnt_done)
                        begin
                            char_fifo_pop <= 1'b1;
                            state <= STOP;
                        end //if (over_sample_cnt_done && bit_cnt_done)
                    end //case DATA
                    
                    STOP:
                    begin
                        if (char_fifo_empty)
                        begin
                            state <= IDLE;
                        end //if (char_fifo_empty)
                        else
                        begin
                            state <= START;
                        end //if (char_fifo_empty)
                    end //case STOP
                endcase //case (state)
            end //if (baud_x16_en)
        end //if (rst)
    end //always @(posedge clk)
    
    assign char_fifo_rd_en = char_fifo_pop && baud_x16_en;
    //end of main fsm
    
    //oversample counter
    always @(posedge clk)
    begin
        if (rst)
        begin
            over_sample_cnt <= 4'd0;
        end //if (rst)
        else
        begin
            if(baud_x16_en)
            begin
                if (!over_sample_cnt_done)
                begin
                    over_sample_cnt <= over_sample_cnt - 1'b1;
                end //if (!over_sample_cnt_done)
                else
                begin
                    if (
                        ((state == IDLE) && !char_fifo_empty) ||
                        (state == START) ||
                        (state == DATA) ||
                        ((state == STOP) && !char_fifo_empty)
                    )
                    begin
                        over_sample_cnt <= 4'd15;
                    end
                end //if (!over_sample_cnt_done)
            end //if(baud_x16_en)
        end //if (rst)
    end //always @(posedge clk)
    
    assign over_sample_cnt_done = (over_sample_cnt == 4'd0);
    //end of oversample counter
    
    //track which bit we are about to send
    always @(posedge clk)
    begin
        if (rst)
        begin
            bit_cnt <= 3'b0;
        end //if (rst)
        else
        begin
            if (baud_x16_en)
            begin
                if (over_sample_cnt_done)
                begin
                    if (state == START)
                    begin
                        bit_cnt <= 3'd0;
                    end //if (state == START)
                    else if (state == DATA)
                    begin
                        bit_cnt <= bit_cnt + 1'b1;
                    end //else if (state == DATA)
                end //if (over_sample_cnt_done)
            end //if (baud_x16_en)
        end //if (rst)
    end //always @(posedge clk)
    //end of bit tracker
    
    //output generation
    always @(posedge clk)
    begin
        if (rst)
        begin
            tx <= 1'b1;
        end //if (rst)
        else
        begin
            if (baud_x16_en)
            begin
                if ((state == STOP) || (state == IDLE))
                begin
                    tx <= 1'b1;
                end //if ((state == STOP) || (state == IDLE))
                else if (state == START)
                begin
                    tx <= 1'b0;
                end //else if (state == START)
                else
                begin
                    tx <= char_fifo_dout[bit_cnt];
                end //else
            end //if (baud_x16_en)
        end //if (rst)
    end //always @(posedge clk)
    //end of output generation
endmodule