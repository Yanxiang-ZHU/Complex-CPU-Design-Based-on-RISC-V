// read the intructions.mem file and load the instructions into memory

module instruction_memory(
        input [31:0] addr,
        output [31:0] instr
    );
    reg [31:0] memory [0:1023];
    integer index;
    integer file;
    integer r;
    reg [31:0] temp_data;

    initial begin
        file = $fopen("instructions.mem", "r");
        if (file) begin
            index = 0;
            while (!$feof(file)) begin
                r = $fscanf(file, "%x", temp_data);
                memory[index] = temp_data;
                index = index + 1;
            end
            $fclose(file);
            $display("Instruction memory loaded successfully.");
        end
        else begin
            $display("Error: Unable to open instrument.mem");
        end
    end

    assign instr = memory[addr[11:2]];
endmodule