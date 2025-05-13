`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/15 18:31:58
// Design Name: 
// Module Name: uart_rx
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


module uart_rx#(
    parameter   						P_SYSTEM_CLK        = 50_000_000	,
    parameter   						P_UART_BAUDRATE     = 9600			,
    parameter   						P_UART_DATA_WIDTH   = 8				,
    parameter   						P_UART_STOP_WIDTH	= 1				,
	parameter							P_UART_CHECK		= 0					// 1 ODD 2 EVEN
)(
    input       						i_clk				,
    input       						i_rst				,

    input       						i_uart_rx			,
    output  [P_UART_DATA_WIDTH - 1 : 0]	o_user_rx_data		,
	output								o_user_rx_valid
);
/***************function**************/

/***************parameter*************/

/***************port******************/             

/***************mechine***************/

/***************reg*******************/
reg  [P_UART_DATA_WIDTH - 1 : 0]	    ro_user_rx_data		;
reg								        ro_user_rx_valid    ;
reg  [15 : 0]							r_cnt				;
reg  [1 : 0]							r_uart_rx			;
reg                                 	r_uart_check        ;

/***************wire******************/

/***************component*************/

/***************assign****************/
assign o_user_rx_data 	= 				ro_user_rx_data		;
assign o_user_rx_valid 	= 				ro_user_rx_valid	;				


/***************always****************/

// r_uart_rx
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst)
		r_uart_rx <= 'b11;
	else 
		r_uart_rx <= {r_uart_rx[0], i_uart_rx};
end

// r_cnt
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst)
		r_cnt <= 'd0;
	else if(r_cnt == 1 + P_UART_DATA_WIDTH + P_UART_STOP_WIDTH - 1 		&& P_UART_CHECK == 0)	// no check
		r_cnt <= 'd0;
	else if(r_cnt == 1 + P_UART_DATA_WIDTH + 1 + P_UART_STOP_WIDTH - 1	&& P_UART_CHECK > 0)	// check
		r_cnt <= 'd0;
	else if(r_uart_rx[1] == 0 || r_cnt > 'd0)
		r_cnt <= r_cnt + 'd1;
	else
		r_cnt <= r_cnt;
end

// ro_user_rx_data
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst)
		ro_user_rx_data <= 'd0;
	else if(r_cnt >= 1 && r_cnt <= P_UART_DATA_WIDTH)
		ro_user_rx_data[r_cnt - 1] <= r_uart_rx[1];
	else 
		ro_user_rx_data <= ro_user_rx_data;
end

// r_uart_check
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst)
		r_uart_check <= 0;
	else if(r_uart_rx[1] == 0 && r_cnt == 'd0) begin			// start
		if(P_UART_CHECK == 1)				
			r_uart_check <= 1;				// odd
		else if(P_UART_CHECK == 2)				
			r_uart_check <= 0;				// even	
	end
	else if(r_cnt >= 1 && r_cnt <= P_UART_DATA_WIDTH)
		r_uart_check = r_uart_check ^ r_uart_rx[1];
	else
		r_uart_check <= 0;
end

// ro_user_rx_valid
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst)
		ro_user_rx_valid <= 0;
	else if(r_cnt == P_UART_DATA_WIDTH + 1) begin
		if(P_UART_CHECK == 0)					// 0 none check
			ro_user_rx_valid <= 1;
		else if(r_uart_check == r_uart_rx[1])
			ro_user_rx_valid <= 1;
		else
			ro_user_rx_valid <= 0;
	end
	else
		ro_user_rx_valid <= 0;
end

endmodule



// `timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 2023/07/09 20:32:42
// // Design Name: 
// // Module Name: uart_rx
// // Project Name: 
// // Target Devices: 
// // Tool Versions: 
// // Description: 
// // 
// // Dependencies: 
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// //////////////////////////////////////////////////////////////////////////////////


// module uart_rx#(
//     parameter                           P_SYSTEM_CLK      = 50_000_000  ,   //输入时钟频率
//     parameter                           P_UART_BAUDRATE   = 9600        ,   //波特率
//     parameter                           P_UART_DATA_WIDTH = 8           ,   //数据宽度
//     parameter                           P_UART_STOP_WIDTH = 1           ,   //1或者2
//     parameter                           P_UART_CHECK      = 0               //None=0 Odd-1 Even-2
// )(                  
//     input                               i_clk                           ,
//     input                               i_rst                           ,

//     input                               i_uart_rx                       ,   //uart的接收数据线，异步。

//     output [P_UART_DATA_WIDTH - 1 : 0]  o_user_rx_data                  ,
//     output                              o_user_rx_valid
// );

// /***************function**************/

// /***************parameter*************/

// /***************port******************/             

// /***************mechine***************/

// /***************reg*******************/
// reg  [P_UART_DATA_WIDTH - 1 : 0]    ro_user_rx_data         ;
// reg                                 ro_user_rx_valid        ;
// reg  [1 :0]                         r_uart_rx               ;
// reg  [15:0]                         r_cnt                   ;
// reg                                 r_rx_check              ;

// /***************wire******************/

// /***************component*************/

// /***************assign****************/
// assign o_user_rx_data   =   ro_user_rx_data         ;
// assign o_user_rx_valid  =   ro_user_rx_valid        ;


// /***************always****************/
// always@(posedge i_clk,posedge i_rst)
// begin
//     if(i_rst)
//         r_uart_rx <= 2'b11;
//     else 
//         r_uart_rx <= {r_uart_rx[0],i_uart_rx}; //r_uart_rx[1]就是打两拍的信号
// end

// always@(posedge i_clk,posedge i_rst)
// begin
//     if(i_rst)
//         r_cnt <= 'd0;
//     else if(r_cnt == 2 + P_UART_DATA_WIDTH + P_UART_STOP_WIDTH - 2 && P_UART_CHECK == 0)
//         r_cnt <= 'd0;
//     else if(r_cnt == 2 + P_UART_DATA_WIDTH + P_UART_STOP_WIDTH - 1 && P_UART_CHECK > 0)
//         r_cnt <= 'd0;
//     else if(i_uart_rx == 0 || r_cnt > 0)
//         r_cnt <= r_cnt + 1;
//     else 
//         r_cnt <= r_cnt;
// end

// always@(posedge i_clk,posedge i_rst)
// begin
//     if(i_rst)
//         ro_user_rx_data <= 'd0;
//     else if(r_cnt >= 1 && r_cnt <= P_UART_DATA_WIDTH)
//         ro_user_rx_data <= {i_uart_rx,ro_user_rx_data[P_UART_DATA_WIDTH - 1 : 1]};//先发低位 8bit
//         // ro_user_rx_data <= {ro_user_rx_data[6:0],r_uart_rx[1]};//先发高位
//     else 
//         ro_user_rx_data <= ro_user_rx_data;
// end

// always@(posedge i_clk,posedge i_rst)
// begin
//     if(i_rst)
//         ro_user_rx_valid    <= 'd0;
//     else if(r_cnt == P_UART_DATA_WIDTH + 0 && P_UART_CHECK == 0)
//         ro_user_rx_valid    <= 'd1;
//     else if(r_cnt == P_UART_DATA_WIDTH + 1 && P_UART_CHECK == 1 && i_uart_rx == !r_rx_check)
//         ro_user_rx_valid    <= 'd1;
//     else if(r_cnt == P_UART_DATA_WIDTH + 1 && P_UART_CHECK == 2 && i_uart_rx == r_rx_check)
//         ro_user_rx_valid    <= 'd1;
//     else 
//         ro_user_rx_valid    <= 'd0;
// end

// // always@(posedge i_clk,posedge i_rst)
// // begin
// //     if(i_rst)
// //         r_rec_tx_check <= 'd0;
// //     else if(r_cnt == P_UART_DATA_WIDTH + 1)
// //         r_rec_tx_check <= r_uart_rx[1];
// //     else 
// //         r_rec_tx_check <= r_rec_tx_check;
// // end

// always@(posedge i_clk,posedge i_rst)
// begin
//     if(i_rst)
//         r_rx_check <= 'd0;
//     else if(r_cnt >= 1 && r_cnt <= P_UART_DATA_WIDTH)//接收数据期间
//         r_rx_check <= r_rx_check ^ i_uart_rx;//异或判断接收的数据里1的个数是奇数还是偶数，结果为1
//     else 
//         r_rx_check <= 'd0;
// end


// endmodule
