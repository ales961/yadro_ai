`timescale 1ns / 1ps

module tb_adder;

    logic clk;
    logic [31:0] a;
    logic [31:0] b;
    logic [31:0] res;

    float32_adder tu (
        .clk(clk),
        .a(a),
        .b(b),
        .res(res)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        a = 32'h3F800000; // 1.0 in IEEE 754
        b = 32'h40000000; // 2.0 in IEEE 754

        #100;

        $display("a = %h, b = %h, res = %h", a, b, res);

        //  if 3.0 in IEEE 754
        if (res == 32'h40400000) begin
            $display("Test passed.");
        end else begin
            $display("Test failed.");
        end

        $stop;
    end

endmodule

