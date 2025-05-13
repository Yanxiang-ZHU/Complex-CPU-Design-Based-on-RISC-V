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


module controller_tb();

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
localparam P_UART_CHECK			= 0;	// 0 NONE 1 ODD 2 EVEN

reg                         		ri_uart_rx			;	
wire                        		wo_uart_tx			;	

reg  [P_UART_DATA_WIDTH - 1 : 0]    ri_user_tx_data  	;		
reg                         		ri_user_tx_valid 	;		
wire                         		wo_user_tx_ready 	;

wire [P_UART_DATA_WIDTH - 1 : 0]	wo_user_rx_data  	;		
wire                         		wo_user_rx_valid 	;

wire								w_user_active		;
wire								w_user_active_2		;

wire								o_user_clk			;
wire								o_user_rst			;

wire								o_user_clk_2		;
wire								o_user_rst_2		;


wire [P_UART_DATA_WIDTH - 1 : 0]    wo_user_rx_data_2  	;	
wire [P_UART_DATA_WIDTH - 1 : 0]    wo_user_tx_data_2  	;
wire                                wo_user_rx_valid_2  ;
wire                                wo_user_tx_valid_2  ;


reg                                 ri_user_tx_valid_2  ;
wire                         		wo_user_tx_ready_2	;

assign	w_user_active = wo_user_tx_ready & ri_user_tx_valid;
assign	w_user_active_2 = wo_user_tx_ready_2 & ri_user_tx_valid_2;

// // input和output测试(写入1)
// always @(posedge o_user_clk or posedge o_user_rst) begin
// 	if(o_user_rst)
// 		ri_user_tx_data <= 'b0000_0000;
// 	else if(w_user_active && ri_user_tx_data == 'b0000_0000)
// 		ri_user_tx_data <= 'b1000_0001;
//     else if (w_user_active && ri_user_tx_data == 'b1000_0001)
// 		ri_user_tx_data <= 'b1010_0001;
// 	else if (w_user_active && ri_user_tx_data == 'b1010_0001)
// 		ri_user_tx_data <= 'b1000_0000;
//     else if (w_user_active && ri_user_tx_data == 'b1000_0000)
//         ri_user_tx_data <= 'b0000_0000;
//     else
//         ri_user_tx_data <= ri_user_tx_data;
// end

// input和output测试2(写入1后擦�?)
always @(posedge o_user_clk or posedge o_user_rst) begin
	if(o_user_rst)
		ri_user_tx_data <= 'b0000_0000;
	else if(w_user_active && ri_user_tx_data == 'b0000_0000)
		ri_user_tx_data <= 'b1000_0010;
    else if(w_user_active && ri_user_tx_data == 'b1000_0010)
		ri_user_tx_data <= 'b1000_0000;
    // // else if (w_user_active && ri_user_tx_data == 'b0000_0001)
	// // 	ri_user_tx_data <= 'b1010_0001;
	// else if (w_user_active && ri_user_tx_data == 'b1000_0000)
	// 	ri_user_tx_data <= 'b1000_0000;
    // else if (w_user_active && ri_user_tx_data == 'b1000_0000)
    //     ri_user_tx_data <= 'b0000_0000;
    else
        ri_user_tx_data <= ri_user_tx_data;
end

initial begin

end

// // output测试3(写入后不停的�?)
// always @(posedge o_user_clk or posedge o_user_rst) begin
// 	if(o_user_rst)
// 		ri_user_tx_data <= 'b0000_0000;
// 	else if(w_user_active && ri_user_tx_data == 'b0000_0000)
// 		ri_user_tx_data <= 'b1010_0001;
//     else if (w_user_active && ri_user_tx_data == 'b1010_0001)
// 		ri_user_tx_data <= 'b1000_0001;
//     else if (w_user_active && ri_user_tx_data == 'b1000_0001)
//         ri_user_tx_data <= 'b1000_0000;
//     else
//         ri_user_tx_data <= ri_user_tx_data;
// end

reg [7:0] cnt;

always @(posedge o_user_clk or posedge o_user_rst) begin
    if (cnt == 8'd20) begin
        cnt <= 0;
    end else if (wo_user_tx_ready) begin
        cnt <= cnt + 1'b1;
    end else begin
        cnt <= 0;
    end
end

// 每隔200clk进行一次数据发送
always @(posedge o_user_clk or posedge o_user_rst) begin
	if(o_user_rst)
		ri_user_tx_valid <= 'd0;
	else if(w_user_active)
		ri_user_tx_valid <= 'd0;
	else if(wo_user_tx_ready && cnt == 8'd20)
		ri_user_tx_valid <= 'd1;
	else
		ri_user_tx_valid <= ri_user_tx_valid;
end

// 该uart用于生成wo_uart_tx，用于uart2 rx的input
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

    .i_uart_rx				(       			)	,
    .o_uart_tx				(wo_uart_tx			)	,

	.i_user_tx_data			(ri_user_tx_data	)	,
	.i_user_tx_valid		(ri_user_tx_valid	)	,
	.o_user_tx_ready		(wo_user_tx_ready	)	, 

    .o_user_rx_data			(               	)	,
	.o_user_rx_valid		(               	)   ,
	.o_user_clk				(o_user_clk      	)	,
	.o_user_rst				(o_user_rst     	)
);

// 和接收到的wo_user_rx_valid_2进行握手，握手后再进行数据发送
always @(posedge o_user_clk_2 or posedge o_user_rst_2) begin
	if(o_user_rst)
		ri_user_tx_valid_2 <= 'd0;
	else if(w_user_active_2)
		ri_user_tx_valid_2 <= 'd0;
	else if(wo_user_tx_ready_2 && wo_user_rx_valid_2)
		ri_user_tx_valid_2 <= 'd1;
	else
		ri_user_tx_valid_2 <= ri_user_tx_valid_2;
end

uart_drive#(
    .P_SYSTEM_CLK        	(50_000_000			),
    .P_UART_BAUDRATE     	(9600				),
    .P_UART_DATA_WIDTH   	(P_UART_DATA_WIDTH	),
    .P_UART_STOP_WIDTH		(1					),
	.P_UART_CHECK			(P_UART_CHECK		)	// 1 ODD 2 EVEN
)	
uart_drive_inst2(	
    .i_clk					(i_clk				),	//50mzh
    .i_rst					(i_rst				),

    .i_uart_rx				(wo_uart_tx			), // uart1的tx输出
    .o_uart_tx				(wo_uart_tx_2 		),

	.i_user_tx_data			(wo_user_tx_data_2  ),
	.i_user_tx_valid		(wo_user_tx_valid_2 ),
	.o_user_tx_ready		(wo_user_tx_ready_2	), 

    .o_user_rx_data			(wo_user_rx_data_2  ),
	.o_user_rx_valid		(wo_user_rx_valid_2 ),
	.o_user_clk				(o_user_clk_2     	),
	.o_user_rst				(o_user_rst_2        )
);

reg  [8:1]  r_virtual_key;
reg  [64:1] r_virtual_sw;
reg  [32:1] r_virtual_led;
reg  [40:1] r_virtual_seg;

wire [8:1]  w_virtual_key;
wire [64:1] w_virtual_sw;
wire [32:1] w_virtual_led;
wire [40:1] w_virtual_seg;


always @(posedge i_clk or posedge i_rst) begin
	if(i_rst) begin
        r_virtual_led <= 'd0;
        r_virtual_seg <= 'd0;
		r_virtual_sw <= 'd0;
        r_virtual_key <= 'd0;
    end
    else begin
        r_virtual_led <= w_virtual_led;
        r_virtual_seg <= w_virtual_seg;
		r_virtual_sw <= w_virtual_sw;
        r_virtual_key <= w_virtual_key;
    end
end


controller cotroller_inst(
    .sys_clk            (i_clk               ),
    .sys_rst            (i_rst               ),
    .i_clk              (o_user_clk_2        ),
    .i_rst              (o_user_rst_2        ),

    .i_user_rx_data     (wo_user_rx_data_2      ),
    .i_user_tx_ready    (wo_user_tx_ready_2     ),
    .i_user_rx_valid    (wo_user_rx_valid_2     ),

    .i_virtual_led      (r_virtual_led          ),
    .i_virtual_seg      (r_virtual_seg          ),
    .i_virtual_key      (r_virtual_key          ),
    .i_virtual_sw       (r_virtual_sw           ),
    .o_virtual_key      (w_virtual_key          ),
    .o_virtual_sw       (w_virtual_sw           ),
    // .o_virtual_led      (w_virtual_led          ),
    // .o_virtual_seg      (w_virtual_seg          ),

    .o_user_tx_data     (wo_user_tx_data_2      ),
    .o_user_tx_valid    (wo_user_tx_valid_2     )
    
);


student_top student_top_inst(
    .w_clk_50Mhz         (i_clk         ),
    .w_clk_rst           (i_rst         ),
    .virtual_key         (w_virtual_key ),
    .virtual_sw          (w_virtual_sw  ),
    .virtual_led         (w_virtual_led ),
    .virtual_seg         (w_virtual_seg )
);

endmodule