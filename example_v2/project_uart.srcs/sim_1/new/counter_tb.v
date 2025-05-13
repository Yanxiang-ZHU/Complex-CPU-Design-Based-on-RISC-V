`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/06 09:05:23
// Design Name: 
// Module Name: counter_tb
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

module counter74160(
    input [3:0] A,     //���������
    input CLK,         //ʱ���ź�
    input CLR,         //�����ź�
    input LOAD,        //�����ź�
    input ENP,         //�������ƶ�
    input ENT,         //�������ƶ�
    output RCO,        //��λ�����
    output [3:0] Q     //���������
);
    reg [3:0] q_cur;
    reg [3:0] q_nxt;
    reg r,clk_nxt;
    
    always@(posedge CLK or negedge CLR) begin
        if(!CLR)begin
            q_cur<=4'b0000;
        end
        else begin
            q_cur<=q_nxt;
        end
    end
    
    always@(*)begin
        r=ENT&q_cur[3]&q_cur[0];
        case({LOAD,ENP,ENT})
            3'b000:begin
                q_nxt<=A;
            end
            3'b001:begin
                q_nxt<=A;
            end
            3'b010:begin
                q_nxt<=A;
            end
            3'b011:begin
                q_nxt<=A;
            end
            3'b111:begin
                if(q_cur<4'b1001) q_nxt<=q_cur+1;
                else  q_nxt<=4'b0000;
            end
            3'b110:begin
                q_nxt<=q_cur;
            end
            3'b101:begin
                q_nxt<=q_cur;
            end
            3'b100:begin
                q_nxt<=q_cur;
            end
            default:begin
                q_nxt<=4'b0000;
            end
        endcase    
    end
    assign Q=q_cur;   
    assign RCO=r;   
endmodule

module DCD_HEX(
    input [3:0] B,
    output reg [6:0] P,
    output DP  
);
    always@(*) begin
        case (B)
            4'b0000: P=7'b0111111; //0
            4'b0001: P=7'b0000110; //1
            4'b0010: P=7'b1011011; //2
            4'b0011: P=7'b1001111; //3
            4'b0100: P=7'b1100110; //4
            4'b0101: P=7'b1101101; //5
            4'b0110: P=7'b1111101; //6
            4'b0111: P=7'b0000111; //7
            4'b1000: P=7'b1111111; //8
            4'b1001: P=7'b1100111; //9
            4'b1010: P=7'b1110111; //A
            4'b1011: P=7'b1111100; //b
            4'b1100: P=7'b0111001; //C
            4'b1101: P=7'b1011110; //d
            4'b1110: P=7'b1111001; //E
            4'b1111: P=7'b1110001; //F
            default: begin
                P=7'b0000000;
            end
        endcase
    end
    assign DP=1'b0;
endmodule
 
module clk_div(
    input clk_in,  //10MHz
    input rst,
    output clk_out
);
    reg [31:0] cnt;
    reg clk_tmp;
    //1Hz
    always@(posedge clk_in or negedge rst) begin
        if(!rst) begin
            cnt<='d0;
            clk_tmp<=1'b0;
        end
        else if(cnt==32'd24999999) begin
            cnt<='d0;
            clk_tmp<=~clk_tmp;
        end
        else begin
            cnt<=cnt+1'b1;
            clk_tmp<=clk_tmp;
        end
    end
    /*
    //100Hz
    always_ff @(posedge clk_in or negedge rst) begin
        if(!rst) begin
            cnt<='d0;
            clk_tmp<=1'b0;
        end
        else if(cnt==32'd49999) begin
            cnt<='d0;
            clk_tmp<=~clk_tmp;
        end
        else begin
            cnt<=cnt+1'b1;
            clk_tmp<=clk_tmp;
        end
    end   
    */
    assign clk_out= clk_tmp;
endmodule

module select(
    input clk,
    input rst,
    input [6:0] P1,
    input [6:0] P2,
    input DP1,
    input DP2,
    output [1:0] CS,
    output reg [6:0] P,
    output reg DP
);
    //λ����
    reg t;
    reg [1:0] CS_tmp;//CS_tmp[0]��λ��Ƭѡ,,CS_tmp[1]ʮλ��Ƭѡ
    
    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            t<=1'b0;
        end
        else begin
            t<=t+1;
        end
    end
    
    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            CS_tmp<=2'b00;
        end
        else if(t) begin
            CS_tmp<=2'b01;
        end
        else begin
            CS_tmp<=2'b10;
        end
    end
    
    //�ο���
    always@(posedge clk) begin
        if(CS_tmp[0]) begin
            P<=P2;//��λ
            DP<=DP2;
        end
        else if(CS_tmp[1]) begin
            P<=P1;//ʮλ
            DP<=DP1;
        end
        else begin
            P<=7'b0000000;
            DP<=1'b0;
        end
     end
     assign CS=CS_tmp;
endmodule

module counter1(
    input clk,rst,
    output [1:0] CS,//CS[0]��λ��Ƭѡ,,CS[1]ʮλ��Ƭѡ
    output [6:0] P,
    output DP
);
    wire clk_out;
    clk_div clk_div_U5(.clk_in(clk),.rst(rst),.clk_out(clk_out));
    
    wire r1;
    wire r2;
    wire [3:0] B1;
    wire [3:0] B2;
    wire[6:0] P1;
    wire [6:0] P2;
    
    //ͬ��Ԥ�÷�
    counter74160 counter74160_U1(.A(4'b0000),.CLK(clk_out),.CLR(1'b1),.LOAD(~(B2[2]&B2[0]&B1[3]&B1[0])),.ENP(1'b1),.ENT(1'b1),.RCO(r1),.Q(B1));
    counter74160 counter74160_U2(.A(4'b0000),.CLK(clk_out),.CLR(1'b1),.LOAD(~(B2[2]&B2[0]&B1[3]&B1[0])),.ENP(r1),.ENT(r1),.RCO(r2),.Q(B2));
//    �������㷨
//    counter74160 counter74160_U1(.A(4'b0000),.CLK(clk_out),.CLR(~(B2[2]&B2[1])),.LOAD(1'b1),.ENP(1'b1),.ENT(1'b1),.RCO(r1),.Q(B1));
//    counter74160 counter74160_U2(.A(4'b0000),.CLK(clk_out),.CLR(~(B2[2]&B2[1])),.LOAD(1'b1),.ENP(r1),.ENT(r1),.RCO(r2),.Q(B2));
    
     wire DP1;
     wire DP2;
     DCD_HEX DCD_HEX_U3(.B(B1),.P(P1),.DP(DP1));//ʮλ
     DCD_HEX DCD_HEX_U4(.B(B2),.P(P2),.DP(DP2));//��λ
     
     select select_U5(.clk(clk),.rst(rst),.P1(P1),.P2(P2),.DP1(DP1),.DP2(DP2),.CS(CS),.P(P),.DP(DP));
 
endmodule




module counter_tb();

reg clk;
reg rst;
wire [10:1] seg8;

initial begin
    clk = 0;
    rst = 1;
    #100 rst = 0;
    #100 rst = 1;
end

always #10 clk = ~clk;

counter1 counter_60_inst(
    .clk            (clk),
    .rst            (rst),
    .CS             ({seg8[10],seg8[9]}),
    .P              (seg8[7:1]),
    .DP             (seg8[8])
);

endmodule
