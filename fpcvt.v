module fpcvt(
    // Outputs
    output wire S,
    output wire [2:0] E,
    output wire [3:0] F,
    output wire [11:0] debug,
    // Inputs
    input [11:0] D
    );

    wire [11:0] mag;

    assign S = D[11];
    assign mag = (S == 1'b0) ? D : 
                    ((D == 12'b100000000000) ? 12'b011111111111 : (~D + 1'b1));

    assign debug=mag;

endmodule