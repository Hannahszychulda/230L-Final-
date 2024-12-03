module top(
    input [3:0] sw,  //select function
    input [15:8] sw,           // Data input
    input clk,                      // Clock
    input btnC,                     //for operation
    input btnU,                     // for reset  
    output [15:0] led, //for A/B display        
    output [6:0] seg,      // 7-segments
    output [3:0] an     // 7-segment display anodes
);

    wire [7:0] Y;  
    reg [7:0] A, B; 

    
    operations alu (  //good
        .A(A),
        .B(B),
        .reset(btnU),
        .do(btnC),
        .select(sw[3:0]),
        .Y(ledY)
        .ledA(led[15:8]),
        .ledB(led[7:0])
    );


    seven_seg display (
        .Y(Y), //output Y value
        .select(sw[3:0]), //operation select
        .seg(seg[6:0]), //display seg
        .anode(an[3:0]) //anode digit select
    );  

endmodule

