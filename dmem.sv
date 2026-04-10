module dmem (
    input logic clk, we,
    input logic [31:0] addr, wd,
    output logic [31:0] rd
);

    logic [31:0] mem[0:255];

    always_ff @(posedge clk)
        if (we) mem[addr[9:2]] <= wd;

    assign rd = mem[addr[9:2]];

endmodule
