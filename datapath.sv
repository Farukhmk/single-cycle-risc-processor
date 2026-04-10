module datapath (
    input logic clk, reset,
    input logic [31:0] instr,
    input logic [31:0] readdata,
    output logic [31:0] pc,
    output logic memwrite
);

    logic [31:0] pcnext, pcplus4;
    logic [31:0] srca, srcb;
    logic [31:0] aluout, writedata, result;
    logic [31:0] imm;

    logic regwrite, alusrc, memtoreg;
    logic [3:0] alucontrol;

    // PC register
    always_ff @(posedge clk or posedge reset)
        if (reset) pc <= 0;
        else pc <= pcnext;

    assign pcplus4 = pc + 4;
    assign pcnext = pcplus4;

    // Controller
    controller ctrl (
        .instr(instr),
        .regwrite(regwrite),
        .memwrite(memwrite),
        .alusrc(alusrc),
        .memtoreg(memtoreg),
        .alucontrol(alucontrol)
    );

    // Register File
    regfile rf (
        .clk(clk),
        .we(regwrite),
        .ra1(instr[19:15]),
        .ra2(instr[24:20]),
        .wa(instr[11:7]),
        .wd(result),
        .rd1(srca),
        .rd2(writedata)
    );

    // Immediate Generator
    immgen ig (
        .instr(instr),
        .imm(imm)
    );

    assign srcb = alusrc ? imm : writedata;

    // ALU
    alu alu_inst (
        .a(srca),
        .b(srcb),
        .alucontrol(alucontrol),
        .result(aluout)
    );

    assign result = memtoreg ? readdata : aluout;

endmodule
