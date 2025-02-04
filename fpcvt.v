module fpcvt(
    // Outputs
    output wire S,
    output wire [2:0] E,
    output wire [3:0] F,
    // output wire [11:0] debug,
    // output wire [3:0] debug2,
    // output wire [2:0] debug3,
    // output wire [3:0] debug4,
    // output wire debug5,
    // output wire debug6,

    // Inputs
    input [11:0] D
);

    wire [11:0] mag;
    wire [3:0] leading_zeros;
    wire fifth_bit;
    wire [3:0] F_unrounded;
    wire [2:0] E_raw;
    wire round_up;
    
    // signed magnitude conversion
    assign S = D[11];
    assign mag = (S == 1'b0) ? D : 
                 ((D == 12'b100000000000) ? 12'b011111111111 : (~D + 1'b1));

    // linear to floating point conversion
    assign leading_zeros = (mag[11] == 1'b1) ? 4'd0  :
                           (mag[10] == 1'b1) ? 4'd1  :
                           (mag[9]  == 1'b1) ? 4'd2  :
                           (mag[8]  == 1'b1) ? 4'd3  :
                           (mag[7]  == 1'b1) ? 4'd4  :
                           (mag[6]  == 1'b1) ? 4'd5  :
                           (mag[5]  == 1'b1) ? 4'd6  :
                           (mag[4]  == 1'b1) ? 4'd7  :
                           (mag[3]  == 1'b1) ? 4'd8  :
                           (mag[2]  == 1'b1) ? 4'd9  :
                           (mag[1]  == 1'b1) ? 4'd10 :
                           (mag[0]  == 1'b1) ? 4'd11 :
                                               4'd12;

    assign E_raw = (leading_zeros >= 8) ? 3'd0 : (8 - leading_zeros);

    assign F_unrounded = (leading_zeros == 4'd0) ? mag[11:8] :
                     (leading_zeros == 4'd1) ? mag[10:7] :
                     (leading_zeros == 4'd2) ? mag[9:6] :
                     (leading_zeros == 4'd3) ? mag[8:5] :
                     (leading_zeros == 4'd4) ? mag[7:4] :
                     (leading_zeros == 4'd5) ? mag[6:3] :
                     (leading_zeros == 4'd6) ? mag[5:2] :
                     (leading_zeros == 4'd7) ? mag[4:1] :
                     (leading_zeros == 4'd8) ? mag[3:0] :
                     (leading_zeros == 4'd9) ? mag[2:0] :
                     (leading_zeros == 4'd10) ? mag[1:0] :
                     mag[0];

    assign fifth_bit = (leading_zeros == 4'd0) ? mag[7] :
                   (leading_zeros == 4'd1) ? mag[6] :
                   (leading_zeros == 4'd2) ? mag[5] :
                   (leading_zeros == 4'd3) ? mag[4] :
                   (leading_zeros == 4'd4) ? mag[3] :
                   (leading_zeros == 4'd5) ? mag[2] :
                   (leading_zeros == 4'd6) ? mag[1] :
                   (leading_zeros == 4'd7) ? mag[0] :
                   1'b0;

    // rounding
    assign round_up = (fifth_bit && (F_unrounded != 4'b1111 || E_raw != 3'b111));
    assign F = round_up ? (F_unrounded == 4'b1111 ? (F_unrounded >> 1) + 1 : F_unrounded + 1) : F_unrounded;
    assign E = (round_up && F_unrounded == 4'b1111) ? (E_raw + 1) : E_raw;

    // Debug outputs
    // assign debug = mag;
    // assign debug2 = leading_zeros;
    // assign debug3 = E_raw;
    // assign debug4 = F_unrounded;
    // assign debug5 = fifth_bit;
    // assign debug6 = round_up;

endmodule
