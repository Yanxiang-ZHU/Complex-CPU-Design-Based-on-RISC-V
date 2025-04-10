module instruction_memory(
    input clk,
    input [31:0] addr,
    output [31:0] instr
);
    wire [31:0] data;

    MEMORY memory_data_operation (
        .clka(clk),
        .wea(4'b0000), 
        .addra(addr >> 2),
        .dina(32'b0),
        .douta(data)
    );
    assign instr = data;

endmodule