`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/15 18:31:58
// Design Name: 
// Module Name: uart_top
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


module uart_top(
    input       						i_sys_clk_p			,	
    input       						i_sys_clk_n			,	
    input       						i_uart_rx			,
    output      						o_uart_tx			
    );

localparam 	P_UART_DATA_WIDTH = 8;

wire 									w_clk_50Mhz			;
wire 									w_clk_rst			;
wire 									w_clk_locked		;

wire [P_UART_DATA_WIDTH - 1 : 0] 		w_user_rx_data		;
wire 									w_user_rx_valid		;

wire                                    w_user_tx_ready     ;
reg                                     r_user_tx_valid     ;
wire [P_UART_DATA_WIDTH - 1 : 0]        w_user_tx_data      ;

wire                                    w_user_clk          ;
wire                                    w_user_rst          ;

reg                                     r_fifo_rden         ;   // 晚一拍
wire                                    w_fifo_empty        ;

assign w_clk_rst = ~w_clk_locked;

PLL PLL_inst
(
    .clk_in1_p          (i_sys_clk_p),
    .clk_in1_n          (i_sys_clk_n),
    .clk_out1           (w_clk_50Mhz),          
    .locked             (w_clk_locked)            
);
// rx -> tx
uart_drive#(
    .P_SYSTEM_CLK        	(50_000_000		),
    .P_UART_BAUDRATE     	(9600			),
    .P_UART_DATA_WIDTH   	(P_UART_DATA_WIDTH),
    .P_UART_STOP_WIDTH		(1				),
	.P_UART_CHECK			(0				)	// 0 NONE 1 ODD 2 EVEN
)
uart_drive_inst(
    .i_clk				(w_clk_50Mhz		),	//50mzh
    .i_rst				(w_clk_rst			),

    .i_uart_rx			(i_uart_rx			),
    .o_uart_tx			(o_uart_tx			),

	.i_user_tx_data		(w_user_rx_data     ),
	.i_user_tx_valid	(w_user_rx_valid    ),
	.o_user_tx_ready	(     ), 

    .o_user_rx_data		(w_user_rx_data		),
	.o_user_rx_valid	(w_user_rx_valid	),

    .o_user_clk			(w_user_clk         ),
    .o_user_rst			(w_user_rst         )
);


// // FIFO 有问题还
// // rx -> tx
// uart_drive#(
//     .P_SYSTEM_CLK        	(50_000_000		),
//     .P_UART_BAUDRATE     	(9600			),
//     .P_UART_DATA_WIDTH   	(P_UART_DATA_WIDTH),
//     .P_UART_STOP_WIDTH		(1				),
// 	.P_UART_CHECK			(0				)	// 0 NONE 1 ODD 2 EVEN
// )
// uart_drive_inst(
//     .i_clk				(w_clk_50Mhz		),	//50mzh
//     .i_rst				(w_clk_rst			),

//     .i_uart_rx			(i_uart_rx			),
//     .o_uart_tx			(o_uart_tx			),

// 	.i_user_tx_data		(w_user_tx_data     ),
// 	.i_user_tx_valid	(r_user_tx_valid    ),
// 	.o_user_tx_ready	(w_user_tx_ready    ), 

//     .o_user_rx_data		(w_user_rx_data		),
// 	.o_user_rx_valid	(w_user_rx_valid	),

//     .o_user_clk			(w_user_clk         ),
//     .o_user_rst			(w_user_rst         )
// );

// UART_FIFO UART_FIFO_inst (
//     .clk                (w_user_clk         ),
//     .srst               (w_user_rst         ),
//     .din                (w_user_rx_data     ),
//     .wr_en              (w_user_rx_valid    ),

//     .rd_en              (r_fifo_rden        ),
//     .dout               (w_user_tx_data     ),
//     .full               (),
//     .empty              (w_fifo_empty       )
// );

// // r_fifo_rden
// always @(posedge w_user_clk or posedge w_user_rst) begin
//     if(w_user_rst) 
//         r_fifo_rden <= 0;
//     else if(w_user_tx_ready && !w_fifo_empty)
//         r_fifo_rden <= 1;
//     else
//         r_fifo_rden <= 0;
// end

// // w_user_rx_valid 要比 fifo 读取数据慢一拍
// always @(posedge w_user_clk or posedge w_user_rst) begin
//     if(w_user_rst) 
//         r_user_tx_valid <= 0;
//     else    
//         r_user_tx_valid <= r_fifo_rden;
// end


endmodule


// `timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 2023/07/13 22:35:07
// // Design Name: 
// // Module Name: UART_TOP
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
// `define VIVADO // Quartus/VIVADO


// module uart_top(
// input       						i_sys_clk_p			,	
// input                               i_sys_clk_n         ,    

//     input               i_uart_rx           ,      
//     output              o_uart_tx                 
// );

// wire                    w_clk_50Mhz         ;
// wire                    w_clk_rst           ;
// wire                    w_system_pll_locked ;

// assign w_clk_rst = ~w_system_pll_locked     ;


// wire [7 :0]             w_user_tx_data  ;
// wire                    w_user_tx_ready ;
// wire [7 :0]             w_user_rx_data  ;
// wire                    w_user_rx_valid ;
// wire                    w_user_clk      ;
// wire                    w_user_rst      ;
// wire                    w_fifo_empty    ;
// reg                     r_fifo_rden     ;
// reg                     r_uart_tx_valid ;
// reg                     r_rden_lock     ;
// reg                     r_user_tx_ready ;


// //`ifdef VIVADO

// //system_pll system_pll_u0
// //(
// //    .clk_in1            (i_clk                  ),
// //    .clk_out1           (w_clk_50Mhz            ),   
// //    .locked             (w_system_pll_locked    )      
// //);

// //`elsif Quartus

// //system_clk system_clk_u0(
// //    .inclk0              (i_clk                  ),
// //    .c0                  (w_clk_50Mhz            ),
// //    .locked              (w_system_pll_locked    )
// //);

// //`endif 

// PLL PLL_inst
// (
//     .clk_in1_p          (i_sys_clk_p),
//     .clk_in1_n          (i_sys_clk_n),
//     .clk_out1           (w_clk_50Mhz),          
//     .locked             (w_system_pll_locked)            
// );

// uart_drive#(
//     .P_SYSTEM_CLK       (50_000_000             ),   //输入时钟频率
//     .P_UART_BAUDRATE    (9600                 ),   //波特�?
//     .P_UART_DATA_WIDTH  (8                      ),   //数据宽度
//     .P_UART_STOP_WIDTH  (1                      ),   //1或�??2
//     .P_UART_CHECK       (0                      )    //None=0 Odd-1 Even-2
// )
// uart_drive_u0
// (                  
//     .i_clk              (w_clk_50Mhz            ),
//     .i_rst              (w_clk_rst              ),  

//     .i_uart_rx          (i_uart_rx              ),
//     .o_uart_tx          (o_uart_tx              ),

//     .i_user_tx_data     (w_user_rx_data         ),
//     .i_user_tx_valid    (w_user_rx_valid        ),
//     .o_user_tx_ready    (                       ),
    
//     .o_user_rx_data     (w_user_rx_data         ),
//     .o_user_rx_valid    (w_user_rx_valid        ),
    
//     .o_user_clk         (w_user_clk             ),
//     .o_user_rst         (w_user_rst             )   
// );

// endmodule