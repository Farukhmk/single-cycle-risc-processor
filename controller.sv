module controller (
    input logic [31:0] instr,
    output logic regwrite, memwrite, alusrc, memtoreg,
    output logic [3:0] alucontrol
);

    logic [6:0] opcode;

    assign opcode = instr[6:0];

    always_comb begin
        case (opcode)
            7'b0110011: begin // R-type
                regwrite = 1;
                alusrc = 0;
                memtoreg = 0;
                memwrite = 0;
                alucontrol = 4'b0000;
            end

            7'b0000011: begin // load
                regwrite = 1;
                alusrc = 1;
                memtoreg = 1;
                memwrite = 0;
                alucontrol = 4'b0000;
            end

            7'b0100011: begin // store
                regwrite = 0;
                alusrc = 1;
                memtoreg = 0;
                memwrite = 1;
                alucontrol = 4'b0000;
            end

            default: begin
                regwrite = 0;
                alusrc = 0;
                memtoreg = 0;
                memwrite = 0;
                alucontrol = 4'b0000;
            end
        endcase
    end

endmodule
