module fpcvt(
    // Outputs
    S,
    E,
    F,
    // Inputs
    D
    );

    output wire S;
    output wire[2:0] E;
    output wire[3:0] F;
    input [11:0] D;

    task twosCompToSignMag;
        input [11:0] twosComp;
        output [11:0] mag;
        output S;
        begin
            // negative numbers
            if (twosComp[11] == 1'b0) begin
                mag = twosComp;
                sign = 1'b0;
            end
            // -2048
            else if (twos_complement == 12'b100000000000) begin
                mag = 12'b011111111111;
                S = 1'b1;
            end
            // general case
            else begin
                mag = ~twos_complement + 1'b1;
                S = 1'b1;
            end
        end
    endtask
endmodule