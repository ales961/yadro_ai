`timescale 1ns / 1ps

module tb_float32_N_adder;
    logic clk;
    logic rst;
    logic [15:0] N;
    logic [31:0] a;
    logic [31:0] res;
    logic valid;

    float32_N_adder tu (
        .clk(clk),
        .rst(rst),
        .N(N),
        .a(a),
        .res(res),
        .valid(valid)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        N = 16'hFFFF;
        a = 0;
        #50;
        rst = 0;

        repeat (N) begin
            a = 32'h3F800000; //32'h4f800000
            @(posedge clk);
        end

        wait(valid);

        $display("Sum = %h", res);
        #50;
        $stop;
    end

endmodule
