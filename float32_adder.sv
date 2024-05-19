`timescale 1ns / 1ps

module float32_adder(
    input clk,
    input  logic [31:0]  a,
    input  logic [31:0]  b,
    output logic [31:0]  res
);

    // Internal signals
    logic [32:0] a_rec;
    logic [32:0] b_rec;
    logic [32:0] sum_rec;
    logic [31:0] sum;
    logic [4:0]  exceptionFlags;
    

    fNToRecFN#(8, 24) a_to_recFN (
        .in(a),
        .out(a_rec)
    );

    fNToRecFN#(8, 24) b_to_recFN (
        .in(b),
        .out(b_rec)
    );

    addRecFN#(8, 24) add (
        .control(1'b0),
        .subOp(1'b0),
        .a(a_rec),
        .b(b_rec),
        .roundingMode(3'b0),
        .out(sum_rec),
        .exceptionFlags(exceptionFlags)
    );

    recFNToFN#(8, 24) recFN_to_FN (
        .in(sum_rec),
        .out(sum)
    );

    always @(posedge clk) begin
        res <= sum;
    end
endmodule

