module riscv_single_cycle (
    input logic clk, reset
);

    logic [31:0] pc, instr, readdata;
    logic memwrite;

    datapath dp (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .readdata(readdata),
        .pc(pc),
        .memwrite(memwrite)
    );

    imem imem_inst (
        .addr(pc),
        .instr(instr)
    );

    dmem dmem_inst (
        .clk(clk),
        .we(memwrite),
        .addr(dp.aluout),
        .wd(dp.writedata),
        .rd(readdata)
    );

endmodule
