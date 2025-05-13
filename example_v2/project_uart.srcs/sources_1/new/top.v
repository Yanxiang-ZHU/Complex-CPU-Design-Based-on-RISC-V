`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2024 03:09:39 PM
// Design Name: 
// Module Name: top
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


module top(
    input       						i_sys_clk_p			,	
    input       						i_sys_clk_n			,	
    input       						i_uart_rx			,

    output      						o_uart_tx			,
    output  [32:1]                      virtual_led         ,
    output  [40:1]                      virtual_seg         
    );

localparam 	                        P_UART_DATA_WIDTH    = 8    ;
localparam                          P_SW_CNT             = 64   ;
localparam                          P_LED_CNT            = 32   ;
localparam                          P_SEG_CNT            = 40   ;
localparam                          P_KEY_CNT            = 8    ;

wire 									w_clk_50Mhz			;
wire 									w_clk_rst			;
wire 									w_clk_locked		;

wire [P_UART_DATA_WIDTH - 1 : 0] 		w_user_rx_data		;
wire 									w_user_rx_valid		;

wire                                    w_user_rx_ready     ;
reg                                     r_user_tx_valid     ;
wire [P_UART_DATA_WIDTH - 1 : 0]        w_user_tx_data      ;

wire                                    w_user_clk          ;
wire                                    w_user_rst          ;


reg  [P_KEY_CNT:1]   r_virtual_key  ; 
reg  [P_SW_CNT:1]    r_virtual_sw   ;

wire [P_KEY_CNT:1]   w_virtual_key  ;
wire [P_SW_CNT:1]    w_virtual_sw   ;
wire [P_LED_CNT:1]   w_virtual_led  ;
wire [P_SEG_CNT:1]   w_virtual_seg  ;

assign w_clk_rst    = ~w_clk_locked;
assign virtual_led  = w_virtual_led;
assign virtual_seg  = w_virtual_seg;

PLL PLL_inst
(
    .clk_in1_p          (i_sys_clk_p),
    .clk_in1_n          (i_sys_clk_n),
    .clk_out1           (w_clk_50Mhz),  
    .clk_out2           (clk),
    .locked             (w_clk_locked)            
);

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

	.i_user_tx_data		(w_user_tx_data     ),
	.i_user_tx_valid	(o_user_tx_valid    ),
	.o_user_tx_ready	(w_user_tx_ready    ), 

    .o_user_rx_data		(w_user_rx_data		),
	.o_user_rx_valid	(w_user_rx_valid	),

    .o_user_clk			(w_user_clk         ),
    .o_user_rst			(w_user_rst         )
);

always @(posedge w_clk_50Mhz or posedge w_clk_rst) begin
	if(w_clk_rst) begin
		r_virtual_sw <= 'd0;
        r_virtual_key <= 'd0;
    end
    else begin
		r_virtual_sw <= w_virtual_sw;
        r_virtual_key <= w_virtual_key;
    end
end


controller #(
    .P_UART_DATA_WIDTH   (P_UART_DATA_WIDTH  ),
    .P_SW_CNT            (P_SW_CNT           ),
    .P_LED_CNT           (P_LED_CNT          ),
    .P_SEG_CNT           (P_SEG_CNT          ),
    .P_KEY_CNT           (P_KEY_CNT          )
) 
controller_inst(
    .sys_clk            (w_clk_50Mhz        ),
    .sys_rst            (w_clk_rst          ),
    .i_clk              (w_user_clk         ),
    .i_rst              (w_user_rst         ),

    .i_user_rx_data     (w_user_rx_data     ),
    .i_user_tx_ready    (w_user_tx_ready    ),
    .i_user_rx_valid    (w_user_rx_valid    ),

    .i_virtual_led      (w_virtual_led      ),
    .i_virtual_seg      (w_virtual_seg      ),
    .i_virtual_key      (r_virtual_key      ),
    .i_virtual_sw       (r_virtual_sw       ),
    .o_virtual_key      (w_virtual_key      ),
    .o_virtual_sw       (w_virtual_sw       ),

    .o_user_tx_data     (w_user_tx_data     ),
    .o_user_tx_valid    (o_user_tx_valid    )
    
);

student_top #(
    .P_SW_CNT            (P_SW_CNT           ),
    .P_LED_CNT           (P_LED_CNT          ),
    .P_SEG_CNT           (P_SEG_CNT          ),
    .P_KEY_CNT           (P_KEY_CNT          )
)
student_top_inst(
    .w_clk_50Mhz         (w_clk_50Mhz   ),
    .w_clk_rst           (w_clk_rst     ),
    .clk                 (clk),
    .virtual_key         (w_virtual_key ),
    .virtual_sw          (w_virtual_sw  ),
    .virtual_led         (w_virtual_led ),
    .virtual_seg         (w_virtual_seg )
);

endmodule