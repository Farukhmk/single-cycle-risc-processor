module imem (
    input logic [31:0] addr,
    output logic [31:0] instr
);

    logic [31:0] mem[0:255];

    initial begin
        mem[0] = 32'h00000033; // dummy instruction
    end

    assign instr = mem[addr[9:2]];

endmodule
