module alu (
    input logic [31:0] a, b,
    input logic [3:0] alucontrol,
    output logic [31:0] result
);

    always_comb begin
        case (alucontrol)
            4'b0000: result = a + b;
            4'b0001: result = a - b;
            4'b0010: result = a & b;
            4'b0011: result = a | b;
            default: result = 0;
        endcase
    end

endmodule
