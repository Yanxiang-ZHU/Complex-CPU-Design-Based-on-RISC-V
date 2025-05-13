`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/16 19:16:57
// Design Name: 
// Module Name: uart_tx_tb
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


module uart_tx_tb();
parameter   						P_SYSTEM_CLK        = 50_000_000	;
parameter   						P_UART_BAUDRATE     = 9600			;
parameter   						P_UART_DATA_WIDTH   = 8				;

reg  i_clk;
reg  i_rst;
wire w_uart_buadclk;
wire w_uart_buadclk_rst;
wire wo_uart_tx;
wire wo_user_tx_ready;

reg  [P_UART_DATA_WIDTH - 1 : 0] i_user_tx_data;
reg  i_user_tx_valid;

initial begin
    i_clk = 0;
    i_rst = 1;
    i_user_tx_data = 'b11001100;
    i_user_tx_valid = 0;

    #1
    i_rst = 0;

    #1000
    i_user_tx_valid = 1;
end

always #10 i_clk = ~i_clk;

localparam LP_CLK_DIV_CNT = P_SYSTEM_CLK / P_UART_BAUDRATE;
clk_div_module#(	
    .P_CLK_DIV_CNT						(LP_CLK_DIV_CNT		)
)
clk_div_module_inst(
    .i_clk          					(i_clk				),
    .i_rst								(i_rst				),
	.o_clk_div							(w_uart_buadclk		)	
);

rst_gen_module#(
    .P_RST_CYCLE (1)
)
rst_gen_module_inst(
    .i_clk       						(w_uart_buadclk		),
    .o_rst      						(w_uart_buadclk_rst	)
);

uart_tx#(
    .P_UART_STOP_WIDTH(2)
)
uart_tx_inst(
    .i_clk								(w_uart_buadclk			),
    .i_rst								(w_uart_buadclk_rst		),
    .o_uart_tx							(wo_uart_tx				),
    .i_user_tx_data						(i_user_tx_data			),
	.i_user_tx_valid					(i_user_tx_valid		),
	.o_user_tx_ready					(wo_user_tx_ready		)
);



endmodule
