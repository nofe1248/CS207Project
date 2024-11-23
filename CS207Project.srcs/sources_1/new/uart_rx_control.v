`timescale 1ns / 1ps

module uart_rx_control(
    input clk,
    input rst,
    input baud_x16_en,
    input rx,
    
    output reg [7:0] rx_data,
    output reg rx_data_ready,
    output reg frame_error
);
    //local parameters
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
    
    //wires
    wire over_sample_cnt_done;
    wire bit_cnt_done;
    
    //body
    
    //main FSM
    always @(posedge clk)
    begin
        if (rst)
        begin
            state <= IDLE;
        end //if (rst)
        else
        begin
            if (baud_x16_en)
            begin
                case (state)
                    IDLE: 
                    begin
                        if (!rx)
                        begin
                            state <= START;
                        end //if (!rx)
                    end //case IDLE
                    
                    START:
                    begin
                        if (over_sample_cnt_done)
                        begin
                            if (!rx)
                            begin
                                state <= DATA;
                            end //if (!rx)
                            else
                            begin
                                state <= IDLE;
                            end //if (!rx)
                        end //if (over_sample_cnt_done)
                    end //case START
                    
                    DATA:
                    begin
                        if (over_sample_cnt_done && bit_cnt_done)
                        begin
                            state <= STOP;
                        end //if (over_sample_cnt_done && bit_cnt_done)
                    end //case DATA
                    
                    STOP:
                    begin
                        if (over_sample_cnt_done)
                        begin
                            state <= IDLE;
                        end //if (over_sample_cnt_done)
                    end //case STOP
                endcase //case (state)
            end //if (baud_x16_en)
        end //if (rst)
    end //always @(posedge clk)
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
            if (baud_x16_en)
            begin
                if (!over_sample_cnt_done)
                begin
                    over_sample_cnt <= over_sample_cnt - 1'b1;
                end //if (!over_sample_cnt_done)
                else
                begin
                    if ((state == IDLE) && !rx)
                    begin
                        over_sample_cnt <= 4'd7;
                    end //if ((state == IDLE) && !rx)
                    else if (((state == START) && !rx) || (state == DATA))
                    begin
                        over_sample_cnt <= 4'd15;                    
                    end //else if (((state == START) && !rx) || (state == DATA))
                end //if (!over_sample_cnt_done)
            end //if (baud_x16_en)
        end //if (rst)
    end //always @(posedge clk)
    
    assign over_sample_cnt_done = (over_sample_cnt == 4'd0);
    //end of oversample counter
    
    //track which bit we are about to receive
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
                    bit_cnt <= 3'd0;
                end //if (over_sample_cnt_done)
                else if (state == DATA)
                begin
                    bit_cnt <= bit_cnt + 1'b1;
                end //else if (state == DATA)
            end //if (baud_x16_en)
        end //if (rst)
    end //always @(posedge clk_rx)
    
    assign bit_cnt_done = (bit_cnt == 3'd7);
    //end of bit tracker
    
    //capture the data and generate the ready signal
    always @(posedge clk)
    begin
        if (rst)
        begin
            rx_data <= 8'b00000000;
            rx_data_ready <= 1'b0;
        end //if (rst)
        else
        begin
            if (baud_x16_en && over_sample_cnt_done)
            begin
                rx_data[bit_cnt] <= rx;
                rx_data_ready <= (bit_cnt == 3'd7);
            end //if (baud_x16_en && over_sample_cnt_done)
            else
            begin
                rx_data_ready <= 1'b0;
            end //if (baud_x16_en && over_sample_cnt_done)
        end //if (rst)
    end //always @(posedge clk)
    //end of ready signal generate
    
    //framing error generation
    always @(posedge clk)
    begin
        if (rst)
        begin
            frame_error <= 1'b0;
        end //if (rst)
        else
        begin
            if (baud_x16_en)
            begin
                if ((state == STOP) && over_sample_cnt_done && !rx)
                begin
                    frame_error <= 1'b1;
                end //if ((state == STOP) && over_sample_cnt_done && !rx)
                else
                begin
                    frame_error <= 1'b0;
                end //if ((state == STOP) && over_sample_cnt_done && !rx)
            end //if (baud_x16_en)
        end //if (rst)
    end //always @(posedge clk)
    //end of framing error generation
endmodule