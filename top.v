module top(

    input [15:8] sw,
    input [3:0] sw,
    input btnC, btnU,
    output [15:0] led, 
    output [3:0] an, 
    output [6:0] seg
);

ALU final (
    .select(sw[3:0]),
    .numbers(sw[15:8]),
    .start(btnC),
    .reset(btnU),
    .ledA(led[15:8]),
    .ledB(led[7:0]),
    .display_segs(seg[6:0]),
    .display_anodes(an[3:0])

)

