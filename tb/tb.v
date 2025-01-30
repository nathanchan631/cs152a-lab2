`timescale 1ns/1ps

module tb;

    reg [11:0] D;
    wire S;
    wire [2:0] E;
    wire [3:0] F;

    wire[11:0] debug;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end 

    fpcvt fpcvt_(
        .D (D),
        .S (S),
        .E (E),
        .F (F),
        .debug (debug)
    );

    initial begin
        $monitor("Time = %0t | D = %b | S = %b | E = %b | F = %b | Debug= %b", 
                 $time, D, S, E, F, debug);

        D = 12'b000000000000; #10;  // 0
        D = 12'b000000000001; #10;  // 1
        D = 12'b000000101010; #10;  // 42
        D = 12'b100000000000; #10;  // -2048
        D = 12'b111111111111; #10;  // -1
        D = 12'b111111101110; #10;  // -34

        $finish;
    end

endmodule