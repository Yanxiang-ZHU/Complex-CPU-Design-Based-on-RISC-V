`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/17 01:09:51
// Design Name: 
// Module Name: uart_drive_tb
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


module uart_drive_tb();

reg  i_clk;
reg  i_rst;

initial begin
    i_clk = 0;
    i_rst = 1;
    #100
    @(posedge i_clk) i_rst = 0;
end

always #10 i_clk = ~i_clk;  //50mhz

localparam P_UART_DATA_WIDTH 	= 8;
localparam P_UART_CHECK			= 2;	// 0 NONE 1 ODD 2 EVEN

reg                         		ri_uart_rx			;	
wire                        		wo_uart_tx			;	

reg  [P_UART_DATA_WIDTH - 1 : 0]    ri_user_tx_data  	;		
reg                         		ri_user_tx_valid 	;		
wire                         		wo_user_tx_ready 	;

wire [P_UART_DATA_WIDTH - 1 : 0]	wo_user_rx_data  	;		
wire                         		wo_user_rx_valid 	;

wire								w_user_active		;

wire								o_user_clk			;
wire								o_user_rst			;


assign	w_user_active = wo_user_tx_ready & ri_user_tx_valid;

// ri_user_tx_data
always @(posedge o_user_clk or posedge o_user_rst) begin
	if(o_user_rst)
		ri_user_tx_data <= 'd0;
	else if(w_user_active)
		ri_user_tx_data <= ri_user_tx_data + 'd1;
	else
		ri_user_tx_data <= ri_user_tx_data;
end

// ri_user_tx_valid
always @(posedge o_user_clk or posedge o_user_rst) begin
	if(o_user_rst)
		ri_user_tx_valid <= 'd0;
	else if(w_user_active)
		ri_user_tx_valid <= 'd0;
	else if(wo_user_tx_ready)
		ri_user_tx_valid <= 'd1;
	else
		ri_user_tx_valid <= ri_user_tx_valid;
end

uart_drive#(
    .P_SYSTEM_CLK        	(50_000_000			),
    .P_UART_BAUDRATE     	(9600				),
    .P_UART_DATA_WIDTH   	(P_UART_DATA_WIDTH	),
    .P_UART_STOP_WIDTH		(1					),
	.P_UART_CHECK			(P_UART_CHECK		)	// 1 ODD 2 EVEN
)	
uart_drive_inst(	
    .i_clk					(i_clk				)	,	//50mzh
    .i_rst					(i_rst				)	,

    .i_uart_rx				(wo_uart_tx			)	,
    .o_uart_tx				(wo_uart_tx			)	,

	.i_user_tx_data			(ri_user_tx_data	)	,
	.i_user_tx_valid		(ri_user_tx_valid	)	,
	.o_user_tx_ready		(wo_user_tx_ready	)	, 

    .o_user_rx_data			(wo_user_rx_data	)	,
	.o_user_rx_valid		(wo_user_rx_valid	)   ,
	.o_user_clk				(o_user_clk			)	,
	.o_user_rst				(o_user_rst			)
);

endmodule
