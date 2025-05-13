module instruction_memory(
    input clk,
    input [31:0] addr,
    output [31:0] instr
);
    wire [31:0] data;
    wire [31:0] data2;
    
    IROM IROM_u (
        .clka(clk),
        .ena(1),
        .wea(4'b0000),
        .addra(addr >> 2),
        .dina(32'b0),
        .douta(data),
        
        .clkb(clk),
        .enb(0),
        .web(0),
        .addrb(0),
        .dinb(0),
        .doutb(data2)
    );
    assign instr = data;

endmodule