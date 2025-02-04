`timescale 1ns/1ps

module tb;

    reg [11:0] D;
    wire S;
    wire [2:0] E;
    wire [3:0] F;

    // wire[11:0] debug;
    // wire[3:0] debug2;
    // wire[2:0] debug3;
    // wire[3:0] debug4;
    // wire debug5;
    // wire debug6;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end 

    fpcvt fpcvt_(
        .D (D),
        .S (S),
        .E (E),
        .F (F)
        // .debug (debug),
        // .debug2 (debug2),
        // .debug3 (debug3),
        // .debug4 (debug4),
        // .debug5 (debug5),
        // .debug6 (debug6)
    );

    // initial begin
    //     $monitor("Time = %0t | D = %b | S = %b | E = %b | F = %b | mag= %b | leading_zeros= %d | E_raw= %b | F_unrounded= %b | fifth_bit= %b | round_up= %b", 
    //              $time, D, S, E, F, debug, debug2, debug3, debug4, debug5, debug6);

    //     D = 12'b000000000000; #10;  // 0
    //     D = 12'b000000000001; #10;  // 1
    //     D = 12'b000000101010; #10;  // 42
    //     D = 12'b001101001010; #10;
    //     D = 12'b001111101010; #10;
    //     D = 12'b011111111111; #10;  // 2047
    //     D = 12'b100000000000; #10;  // -2048
    //     D = 12'b111111111111; #10;  // -1
    //     D = 12'b111111101110; #10;  // -34

    //     D = 12'b000000000001; #10;
    //     D = 12'b111111111111; #10;

    //     $finish;
    // end

endmodule