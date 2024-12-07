module seven_seg(
    input [7:0] Y,               // ALU output
    input [3:0] select, // Select
    output reg [6:0] seg,         // 7-segment display output
    output reg [3:0] anode  
          
);

    reg [6:0] segs[0:9]; // 0-9

    initial begin
        // close... but you actually
        // need to display 0-F (hexidecimal)
        // There is example code in Week 10
        // 7-segment display 0-9
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
       
    end

    always @(*) begin
        case (anode)
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
    end
endmodule
