`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2025 03:04:25 PM
// Design Name: 
// Module Name: counter
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


module counter(
    input  logic         clk,
    input  logic         rst,

    input  logic [31:0]  perip_wdata,
    input  logic         cnt_wen,
    output logic [31:0]  perip_rdata
);

    logic [15:0] cnt_1ms;
    logic [31:0] cnt_ms;
    logic start;

    always_ff @(posedge clk) begin
        if (rst) begin
            start <= 0;
        end else if (cnt_wen & perip_wdata == 32'h8000_0000) begin
            start <= 1;
        end else if (cnt_wen & perip_wdata == 32'hFFFF_FFFF) begin
            start <= 0;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            cnt_1ms <= 0;
        end else if (start) begin
            if (cnt_1ms == 49999) begin
                cnt_1ms <= 0;
            end else begin
                cnt_1ms <= cnt_1ms + 1;
            end
        end else begin
            cnt_1ms <= 0;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            cnt_ms <= 0;
        end else if (start && cnt_1ms == 49999) begin
            cnt_ms <= cnt_ms + 1;
        end
    end

    assign perip_rdata = cnt_ms;

endmodule
