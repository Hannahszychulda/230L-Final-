module operations(
    // I would make A, B, Y all output regs of this module
    // since it generates the values for all three
    input [7:0] A,        // A data
    input [7:0] B,        // B data
    input reset, 
    input do, 
    input clk,
    input [3:0] select,  // select
    output reg [7:0] Y,     // output
    output [7:0] ledA, ledB
);
//operations assigned via select
    always @(posedge clk or posedge reset) begin
         if (reset) begin
            // These assignments to A and B are the
            // reason I say to make A, B, Y output regs
            A <= 8'b0;
            B <= 8'b0;
            Y <= 8'b0;

        end else if (do) begin
        case (select)
            // The operations ADD, SUB, and NEG should all use week 6 modules
            4'b0000: Y <= A + B;            // ADD
            4'b0001: Y <= A - B;            // SUB
            4'b0010: Y <= A << 1;           // SHL 
            4'b0011: Y <= A >> 1;           // SHR 
            // Comparison is close. We want to return:
            // 0 if equivalent
            // 1 if A > B
            // -1 if A < B
            // Your code here can only return 0 and -1
            4'b0100: Y <= (A == B) ? 8'hFF : 8'h00;  // CMP (Comparison)
            4'b0101: Y <= A & B;            // AND
            4'b0110: Y <= A | B;            // OR
            4'b0111: Y <= A ^ B;            // XOR
            4'b1000: Y <= ~(A & B);         // NAND
            4'b1001: Y <= ~(A | B);         // NOR
            4'b1010: Y <= ~(A ^ B);         // XNOR
            4'b1011: Y <= ~A;               // NOT
            4'b1100: Y <= -A;               // NEG 
            // STO should be Y into A, not A into A
            4'b1101: A <= A;               // STO 
            // Swap and load are...swapped
            // These assignments to A and B are the
            // reason I say to make A, B, Y output regs
            4'b1110: A <= B;               // SWP
            4'b1111: {A,B} <= {B,A};        // LOAD
            // Don't need a default case -- you've handled all 16 possible combinations
            // of four bits
            default: Y <= 8'b00000000;      // Default
        endcase
    end
    end 

//assign leds
    assign ledA = A;
    assign ledB = B;


endmodule
