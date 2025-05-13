`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/15 18:31:58
// Design Name: 
// Module Name: uart_drive
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


module uart_drive#(
    parameter   						P_SYSTEM_CLK        = 50_000_000	,
    parameter   						P_UART_BAUDRATE     = 9600			,
    parameter   						P_UART_DATA_WIDTH   = 8				,
    parameter   						P_UART_STOP_WIDTH	= 1				,
	parameter							P_UART_CHECK		= 0					// 0 NONE 1 ODD 2 EVEN
)(
    input       						i_clk				,	                //50mzh
    input       						i_rst				,

    input       						i_uart_rx			,
    output      						o_uart_tx			,

	input	[P_UART_DATA_WIDTH - 1 : 0]	i_user_tx_data		,
	input								i_user_tx_valid		,
	output								o_user_tx_ready		, 

    output  [P_UART_DATA_WIDTH - 1 : 0]	o_user_rx_data		,
	output								o_user_rx_valid		,

	output								o_user_clk			,
	output								o_user_rst			
);

wire w_uart_buadclk;
wire w_uart_buadclk_rst;

localparam LP_CLK_DIV_CNT = P_SYSTEM_CLK / P_UART_BAUDRATE;
clk_div_module#(	
    .P_CLK_DIV_CNT						(LP_CLK_DIV_CNT		)
)
clk_div_module_inst(
    .i_clk          					(i_clk				),
    .i_rst								(i_rst				),
	.o_clk_div							(w_uart_buadclk		)	
);

// new rst adapts to divided clk
rst_gen_module#(
    .P_RST_CYCLE (3)
)
rst_gen_module_inst(
    .i_clk       						(w_uart_buadclk		),
    .o_rst      						(w_uart_buadclk_rst	)
);

assign o_user_clk = w_uart_buadclk;
assign o_user_rst = w_uart_buadclk_rst;

uart_rx#(
    .P_SYSTEM_CLK        				(P_SYSTEM_CLK			),
    .P_UART_BAUDRATE     				(P_UART_BAUDRATE		),
    .P_UART_DATA_WIDTH   				(P_UART_DATA_WIDTH		),
    .P_UART_STOP_WIDTH	 				(P_UART_STOP_WIDTH		),
    .P_UART_CHECK			            (P_UART_CHECK			)
)
uart_rx_inst(
    .i_clk								(w_uart_buadclk			),
    .i_rst								(w_uart_buadclk_rst		),
    .i_uart_rx							(i_uart_rx				),
    .o_user_rx_data						(o_user_rx_data			),
	.o_user_rx_valid					(o_user_rx_valid		)
);

uart_tx#(
    .P_SYSTEM_CLK        				(P_SYSTEM_CLK			),
    .P_UART_BAUDRATE     				(P_UART_BAUDRATE		),
    .P_UART_DATA_WIDTH   				(P_UART_DATA_WIDTH		),
    .P_UART_STOP_WIDTH	 				(P_UART_STOP_WIDTH		),
    .P_UART_CHECK			            (P_UART_CHECK			)
)
uart_tx_inst(
    .i_clk								(w_uart_buadclk			),
    .i_rst								(w_uart_buadclk_rst		),
    .o_uart_tx							(o_uart_tx				),
    .i_user_tx_data						(i_user_tx_data			),
	.i_user_tx_valid					(i_user_tx_valid		),
	.o_user_tx_ready					(o_user_tx_ready		)
);

endmodule

