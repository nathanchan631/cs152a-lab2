module tb;

    wire [11:0] D;
    wire S;
    wire [2:0] E;
    wire [3:0] F;

    wire[11:0] mag;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end 

    initial begin
        D = 12'b000110100110

        twosCompToSignMag(D, mag, S);
        $finish
    end

    fpcvt fpcvt_(
        .D (D),
        .S (S),
        .E (E),
        .F (F)
    );

endmodule