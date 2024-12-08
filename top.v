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

    twocomplimentneg NEG (
        .A(A),
        .Twos(Y),
        .select(sw[3:0]),
        .reset(btnU)
	);

    twocomplimentsub SUB (
        .A(A),
        .B(B),
        .Twos(Y),
        .select(sw[3:0]),
        .reset(btnU)
	);

    twocomplimentadd ADD (
        .A(A),
        .B(B),
        .Twos(Y),
        .select(sw[3:0]),
        .reset(btnU)
	);
    
    operations alu (  //good
        .A(A),
        .B(B),
        .reset(btnU),
        .do(btnC),
        .select(sw[3:0]),
        // Y is not shown on the LEDs, but rather
        // as the left and left center 7 segs
        .Y(ledY)
        .ledA(led[15:8]),
        .ledB(led[7:0])
    );


    // The seven seg display is close, but you are
    // missing the clock divider module to drive it.
    // Since you missed lab 10, I'll grade this without
    // that in mind, and only on your ALU. done
    seven_seg display (
        .Y(Y), //output Y value
        .select(sw[3:0]), //operation select
        .clk(clk),
        .seg(seg[6:0]), //display seg
        .anode(an[3:0]) //anode digit select
    );  

endmodule

