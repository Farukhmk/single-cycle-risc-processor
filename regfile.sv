module regfile (
    input logic clk, we,
    input logic [4:0] ra1, ra2, wa,
    input logic [31:0] wd,
    output logic [31:0] rd1, rd2
);

    logic [31:0] rf[0:31];

    assign rd1 = rf[ra1];
    assign rd2 = rf[ra2];

    always_ff @(posedge clk)
        if (we) rf[wa] <= wd;

endmodule
