`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/15 11:52:05
// Design Name: 
// Module Name: CLK_DIV_module
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


module clk_div_module#(
    parameter       P_CLK_DIV_CNT   = 2
)(
    input           i_clk               ,
    input			i_rst				,
	output			o_clk_div			
);

/***************function**************/

/***************parameter*************/

/***************port******************/             

/***************mechine***************/

/***************reg*******************/
reg  				ro_clk_div;
reg  [15 : 0]		r_cnt;
/***************wire******************/

/***************component*************/

/***************assign****************/
assign o_clk_div = ro_clk_div;
/***************always****************/

// r_cnt
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst)
		r_cnt <= 'd0;
	else if(r_cnt == (P_CLK_DIV_CNT >> 1) - 1)
		r_cnt <= 'd0;
	else
		r_cnt <= r_cnt + 'd1;
end

// ro_clk_div
always @(posedge i_clk or posedge i_rst) begin
	if(i_rst)
		ro_clk_div <= 0;
	else if(r_cnt == (P_CLK_DIV_CNT >> 1) - 1)
		ro_clk_div <= ~ro_clk_div;
	else
		ro_clk_div <= ro_clk_div;
end

endmodule

