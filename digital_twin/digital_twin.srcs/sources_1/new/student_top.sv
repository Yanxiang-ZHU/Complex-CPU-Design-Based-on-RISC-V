`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2025 06:21:13 PM
// Design Name: 
// Module Name: student_top
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


module student_top#(
    parameter                           P_SW_CNT            = 64,
    parameter                           P_LED_CNT           = 32,
    parameter                           P_SEG_CNT           = 40,
    parameter                           P_KEY_CNT           = 8
) (
    input                                       w_clk_50Mhz   ,
    input                                       w_clk_rst     ,
    input  [P_KEY_CNT - 1:0]                    virtual_key   ,
    input  [P_SW_CNT  - 1:0]                    virtual_sw    ,

    output [P_LED_CNT - 1:0]                    virtual_led   ,
    output [P_SEG_CNT - 1:0]                    virtual_seg   
);
     // You can revise the design below to finish your design. Let's go.
    // assign virtual_led = virtual_sw[31:0];
    // assign virtual_seg = {virtual_key, virtual_sw[63:32]};
    SPIC_Pipeline SPIC_Pipeline_u (
        .clk  (w_clk_50Mhz),
        .rst  (rst)
    );
    // If you want to know more about the function of the virtual_seg driver
    // please read Appendix 4: https://jyq2umyqyt.feishu.cn/docx/Fdkod8H4folLbexKQSCcwXbMnKc
 
    assign virtual_led = virtual_sw[31:0];
 
    display_seg seg_driver (
        .clk    (w_clk_50Mhz),
        .rst    (w_clk_rst),
        .s      (virtual_sw[63:32]),
        .seg1   (virtual_seg[6:0]),
        .seg2   (virtual_seg[16:10]),
        .seg3   (virtual_seg[26:20]),
        .seg4   (virtual_seg[36:30]),
        .ans    ({virtual_seg[39:38], virtual_seg[29:28], virtual_seg[19:18], virtual_seg[9:8]})
    ); 

    assign virtual_seg[7] = virtual_key[0];
    assign virtual_seg[17] = virtual_key[1];
    assign virtual_seg[27] = virtual_key[2];
    assign virtual_seg[37] = virtual_key[3];

endmodule
