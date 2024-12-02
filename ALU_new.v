module ALU(
    input [3:0] select,         // select
    input [7:0] numbers,       // A input
    input start,                // start
    input reset,                // reset
    output reg [7:0] ledA,     // DisplayA
    output reg [7:0] ledB,   // DisplayB
    output reg [7:0] ledY,  //DisplayY
    output reg [6:0] display_segs,      // 7-seg display
    output reg [3:0] display_anodes        // Anodes
);

    reg [7:0] A, B;            // 8-bit registers A and B
    reg [7:0] Y;               // 8-bit result register (Y)
    reg [6:0] seg[0:9]; 

//assigns segments to values 0-6
    initial begin
        seg[0] = 7'b1111110;  // 0
        seg[1] = 7'b0110000;  // 1
        seg[2] = 7'b1101101;  // 2
        seg[3] = 7'b1111001;  // 3
        seg[4] = 7'b0110011;  // 4
        seg[5] = 7'b1011011;  // 5
        seg[6] = 7'b1011111;  // 6
        seg[7] = 7'b1110000;  // 7
        seg[8] = 7'b1111111;  // 8
        seg[9] = 7'b1111011;  // 9
    end 

    always @(*) begin
    //Reset to zero, reset op
        if (reset) begin
            A <= 8'b0;
            B <= 8'b0;
            Y <= 8'b0;
        end 

        else begin  //selects operation depedent on 4bit input
        case (select)
                4'b0000: Y <= A + B;        // Add
                4'b0001: Y <= A - B;        // Sub
                4'b0010: Y <= A << 1;       // Shift left
                4'b0011: Y <= A >> 1;       // Shift right
                4'b0100: Y <= (A == B) ? 8'hFF : 8'h00;  // Comparison (1 if A == B)
                4'b0101: Y <= A & B;        // AND
                4'b0110: Y <= A | B;        // OR
                4'b0111: Y <= A ^ B;        // XOR
                4'b1000: Y <= ~(A & B);     // NAND
                4'b1001: Y <= ~(A | B);     // NOR
                4'b1010: Y <= ~(A ^ B);     // XNOR
                4'b1011: Y <= ~A;           // NOT 
                4'b1100: Y <= ~A + 1;       // Two's comp
                4'b1101: Y <= A;            // Store A -> Y
                4'b1110: {A, B} <= {B, A};  // Swap 
                4'b1111: A <= numbers[15:8];  // Load A
                default: Y <= 8'b0;
            endcase
        end
    end

     always @(*) begin   //not sure what to put for sensitivities 
        ledA <= A;
        ledB <= B;
        ledY <= Y;

        case(display_anodes)
        4'b1110: display_segs = seg[select]; //select value for R anode
        //4'b1101 RC is N/A
        4'b1011: display_segs = seg[Y[3:0]]; //Rightmost of Y for LC anode
        4'b0111: display_segs = seg[Y[7:4]]; //Leftmost of Y for L anode
        endcase
    end

endmodule
        
        