module seven_seg(
    input [7:0] Y,               // ALU output
    input [3:0] select, // Select
    input clk,
    output reg [6:0] seg,         // 7-segment display output
    output reg [3:0] anode  
          
);

    reg [6:0] segs[0:15]; // 0-9
    reg [15:0] clkdiv;
    reg [1:0] newanode;

    always @(posedge clk) begin
        clkdiv <= clkdiv + 1;

    initial begin

        segs[0] = 7'b0000001;  // 0
        segs[1] = 7'b1001111;  // 1
        segs[2] = 7'b0010010;  // 2
        segs[3] = 7'b0000110;  // 3
        segs[4] = 7'b1001100;  // 4
        segs[5] = 7'b0100100;  // 5
        segs[6] = 7'b0100000;  // 6
        segs[7] = 7'b0001111;  // 7
        segs[8] = 7'b0000000;  // 8
        segs[9] = 7'b0000100;  // 9
        segs[10] = 7'b0001000;  // A
        segs[11] = 7'b1100000;  // b
        segs[12] = 7'b0110001;  // C
        segs[13] = 7'b1000010;  // d
        segs[14] = 7'b0110000;  // E
        segs[15] = 7'b0111000;  // F
       
    end

    always @(posedge clkdiv) begin
        case (newanode)
            2'b00: begin  // R
                anode = 4'b1110;  
                seg = segs[select];  // select
            end
            2'b01: begin  // RC
                anode = 4'b1101;  
                seg = 7'b1111111;  // nothing to show
            end
            2'b10: begin  // LC
                anode = 4'b1011;  
                seg = segs[Y[3:0]];  // last 4 of Y
            end
            2'b11: begin  // L
                anode = 4'b0111;  
                seg = segs[Y[7:4]];  // first 4 of y
            end
            default: begin
                anode = 4'b1111;  // OFF
                seg = 7'b1111111;  // OFF
            end
        endcase

        newanode <= newanode+1;
    end
endmodule
