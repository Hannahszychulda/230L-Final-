module twoscomplimentsub(
    input [7:0] A, B,
    input [3:0] select, 
    input reset,
    output [7:0] Twos
);


wire around0, around1, around2, around3, around4, around5, around6;
wire [7:0] negate;

assign negate = ~B;

fulladder Twos0(
    .A(A[0]),
    .B(negate[0]),
    .Cin(1'b0),
    .Y(Twos[0]),
    .Carry(around0)
);

fulladder Twos1(
    .A(A[1]),
    .B(negate[1]),
    .Cin(around0),
    .Y(Twos[1]),
    .Carry(around1)
);

fulladder Twos2(
    .A(A[2]),
    .B(negate[2]),
    .Cin(around1),
    .Y(Twos[2]),
    .Carry(around2)
);

fulladder Twos3(
    .A(A[3]),
    .B(negate[3]),
    .Cin(around2),
    .Y(Twos[3]),
    .Carry(around3)
);

fulladder Twos4(
    .A(A[4]),
    .B(negate[4]),
    .Cin(around3),
    .Y(Twos[4]),
    .Carry(around4)
);

fulladder Twos5(
    .A(A[5]),
    .B(negate[5]),
    .Cin(around4),
    .Y(Twos[5]),
    .Carry(around5)
);

fulladder Twos6(
    .A(A[6]),
    .B(negate[6]),
    .Cin(around5),
    .Y(Twos[6]),
    .Carry(around6)
);

fulladder Twos7(
    .A(A[7]),
    .B(negate[7]),
    .Cin(around6),
    .Y(Twos[7])
);

always @(posedge clk or posedge reset) begin
         if (reset) begin
            // These assignments to A and B are the
            // reason I say to make A, B, Y output regs
            A <= 8'b0;
            B <= 8'b0;
            Y <= 8'b0;

        end else if (do) begin
        case (select)
        4'b0000: Y <= Twos; //set y equal to A+B


endmodule