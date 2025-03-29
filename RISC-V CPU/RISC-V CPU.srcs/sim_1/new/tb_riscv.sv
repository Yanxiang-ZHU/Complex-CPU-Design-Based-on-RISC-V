`timescale 1ns / 1ps

module tb_riscv;
    reg clk, rst;
    wire [31:0] pc_out;

    always #10 clk = ~clk;

    SPIC uut (
        .clk(clk),
        .rst(rst),
        .pc_out(pc_out)
    );

    initial begin
        clk = 0;
        rst = 1;
        #20 rst = 0;
        #1000;
        $finish;
    end
    
endmodule
