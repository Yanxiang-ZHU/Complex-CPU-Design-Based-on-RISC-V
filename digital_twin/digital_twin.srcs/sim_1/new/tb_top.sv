`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2025 06:28:41 PM
// Design Name: 
// Module Name: tb_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_top;
    reg clk;

    reg serial_rx;          
    wire serial_tx;         
    
    reg [7:0] rx_data[0:17];
    integer j;
    
    top uut (
        .i_sys_clk_p(clk),
        .i_sys_clk_n(~clk),
        .i_uart_rx(serial_rx),
        .o_uart_tx(serial_tx),
        .virtual_led(),  
        .virtual_seg()
    );
    

    //  clock 50MHz=2.5 20ns
    initial begin
        clk = 0;
        forever #2.5 clk = ~clk;
    end

    initial begin
        serial_rx = 1;
        #200;
    end

    task uart_send_byte(input [7:0] data);
        integer i;
        begin
            serial_rx = 0;  // start bit
            #(104166);      // baud 9600, 1bit = 1/9600s = 104166ns

            for(i = 0; i < 8; i = i + 1) begin
                serial_rx = data[i];
                #(104166);
            end

            serial_rx = 1;  // stop bit
            #(104166);
        end
    endtask

    task uart_receive_byte(output [7:0] data);
        integer i;
        begin
            // wait for start bit
            wait(serial_tx == 0);
            #(52083);  // half of a process

            for(i = 0; i < 8; i = i + 1) begin
                #(104166);
                data[i] = serial_tx;
            end

            #(104166); // stop bit
        end
    endtask

    initial begin
        #1000;

        $display("==== send 0x00 to uart_rx ====");
        uart_send_byte(8'h00);
        
        fork
            begin: RX_MONITOR
                wait(serial_tx == 0);
                $display("ERROR: 0x00 should not have tx data?");
                $finish;
            end
            begin: TIMEOUT
                #100000;
                disable RX_MONITOR;
                $display("PASS: 0x00 instruction");
            end
        join

        $display("==== send 0x81 SW[0]=1 ====");
        uart_send_byte(8'b10000001);
        #2000;
        
        $display("==== send 0xa0 SW[31]=1 ====");
        uart_send_byte(8'b10000001 + 31); 
        #2000;

        $display("==== send 0xc1 KEY[0]=1 ====");
        uart_send_byte(8'b10000000 + 65);
        #2000;

        $display("==== send 0x80 read 18bit data  ====");
        uart_send_byte(8'h80); 
          
        for(j = 0; j < 18; j = j + 1) begin
            uart_receive_byte(rx_data[j]);
            $display("RX[%0d] = %02x", j, rx_data[j]);
        end

        if(rx_data[5][0] !== 1'b1 || rx_data[6][0] != 1'b1 || rx_data[9][7] != 1'b1)
            $display("ERROR: SW[0] KEY[0] SW[31] data right");
        else
            $display("PASS: SW[0] KEY[0] SW[31] data error");
           
        $finish;
    end
endmodule

