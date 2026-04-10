module immgen (
    input logic [31:0] instr,
    output logic [31:0] imm
);

    always_comb begin
        imm = {{20{instr[31]}}, instr[31:20]}; // simple I-type
    end

endmodule
