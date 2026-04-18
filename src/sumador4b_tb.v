`timescale 1ns/1ps

module tb_sumador_4b;

    // Entradas
    reg clk;
    reg rst;
    reg [3:0] a_in;
    reg [3:0] b_in;
    reg cin_in;

    // Salidas
    wire [3:0] sum_out;
    wire cout_out;

    // DUT
    sumador_4b uut (
        .clk(clk),
        .rst(rst),
        .a_in(a_in),
        .b_in(b_in),
        .cin_in(cin_in),
        .sum_out(sum_out),
        .cout_out(cout_out)
    );

    // ----------------------------
    // Reloj
    // ----------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ----------------------------
    // Dump VCD
    // ----------------------------
    initial begin
        $dumpfile("sumador_4b.vcd");
        $dumpvars(0, tb_sumador_4b);
    end

    // ----------------------------
    // Estímulos (negedge)
    // ----------------------------
    initial begin
        // Inicialización
        rst = 1;
        a_in = 0;
        b_in = 0;
        cin_in = 0;

        #12;
        rst = 0;

        // Caso 1
        @(negedge clk);
        a_in = 4'd3;
        b_in = 4'd2;
        cin_in = 0;

        // Caso 2
        @(negedge clk);
        a_in = 4'd7;
        b_in = 4'd8;
        cin_in = 0;

        // Caso 3 (overflow)
        @(negedge clk);
        a_in = 4'd15;
        b_in = 4'd1;
        cin_in = 0;

        // Caso 4 (con carry in)
        @(negedge clk);
        a_in = 4'd5;
        b_in = 4'd5;
        cin_in = 1;

        // Aleatorios
        repeat (5) begin
            @(negedge clk);
            a_in = $random % 16;
            b_in = $random % 16;
            cin_in = $random % 2;
        end

        #20;
        $finish;
    end

    // ----------------------------
    // Monitor
    // ----------------------------
    initial begin
        $monitor("T=%0t | a=%d b=%d cin=%b | sum=%d cout=%b",
                  $time, a_in, b_in, cin_in, sum_out, cout_out);
    end

endmodule