`timescale 1ns / 1ps

module float32_N_adder(
    input clk,
    input rst,
    input  logic [15:0]  N,
    input  logic [31:0]  a,
    output logic [31:0]  res,
    output logic valid
);

    logic [31:0] part_res;
    logic [31:0] b;
    logic [15:0] ctr;
    float32_adder inst (
        .clk(clk),
        .a(a),
        .b(b),
        .res(part_res)
    );
    
    always @(negedge clk) begin
        if (rst) begin
            valid <= 0;
            b <= 0;
            res <= 0;
            ctr <= 0;
        end else begin
            if (ctr == N) begin
                res <= part_res;
                valid <= 1;
            end else begin
                b <= part_res;
                ctr <= ctr + 1;
            end
        end
    end
endmodule
