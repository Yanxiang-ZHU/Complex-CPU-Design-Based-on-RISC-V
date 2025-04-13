`timescale 1ns / 1ps

module tb_riscv;
    reg clk, rst;
    always #10 clk = ~clk;

    SPIC_Pipeline uut (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk = 0;
        rst = 1;
        #20 rst = 0;
        #1000;
        $finish;
    end
    
endmodule
