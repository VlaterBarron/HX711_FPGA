module bcd_to_7seg_mux(
    input clk,
    input [23:0] bcd,
    output wire [6:0] segA,
    output wire [6:0] segB,
	 output wire [6:0] segC,
	 output wire [6:0] segD,
	 output wire [6:0] segE,
	 output wire [6:0] segF
);

reg [2:0] display_mux;
reg [6:0] display_dataA;
reg [6:0] display_dataB;
reg [6:0] display_dataC;
reg [6:0] display_dataD;
reg [6:0] display_dataE;
reg [6:0] display_dataF;

assign segA = display_dataA;
assign segB = display_dataB;
assign segC = display_dataC;
assign segD = display_dataD;
assign segE = display_dataE;
assign segF = display_dataF;

always @ (posedge clk) begin
    // Increment display multiplexer
    display_mux <= display_mux + 1'b1;
    
    // Assign display data based on current multiplexer state
    case (display_mux)
        3'b000: begin
            display_dataA = bcd_to_7seg(bcd[3:0]);
            display_dataB = 7'b1111111; // Blank display
				display_dataC = 7'b1111111; // Blank display
				display_dataD = 7'b1111111; // Blank display
				display_dataE = 7'b1111111; // Blank display
				display_dataF = 7'b1111111; // Blank display
        end
        3'b001: begin
            display_dataA = 7'b1111111; // Blank display
            display_dataB = bcd_to_7seg(bcd[7:4]);
				display_dataC = 7'b1111111; // Blank display
				display_dataD = 7'b1111111; // Blank display
				display_dataE = 7'b1111111; // Blank display
				display_dataF = 7'b1111111; // Blank display
		  end
		  3'b010: begin
            display_dataA = 7'b1111111; // Blank display
            display_dataB = 7'b1111111; // Blank display
				display_dataC = bcd_to_7seg(bcd[11:8]);
				display_dataD = 7'b1111111; // Blank display
				display_dataE = 7'b1111111; // Blank display
				display_dataF = 7'b1111111; // Blank display
			end
			3'b011: begin
            display_dataA = 7'b1111111; // Blank display
            display_dataB = 7'b1111111; // Blank display
				display_dataC = 7'b1111111; // Blank display
				display_dataD = bcd_to_7seg(bcd[15:12]);
				display_dataE = 7'b1111111; // Blank display
				display_dataF = 7'b1111111; // Blank display
        end
		  3'b100: begin
            display_dataA = 7'b1111111; // Blank display
            display_dataB = 7'b1111111; // Blank display
				display_dataC = 7'b1111111; // Blank display
				display_dataD = 7'b1111111; // Blank display
				display_dataE = bcd_to_7seg(bcd[19:16]);
				display_dataF = 7'b1111111; // Blank display
        end
		  3'b101: begin
            display_dataA = 7'b1111111; // Blank display
            display_dataB = 7'b1111111; // Blank display
				display_dataC = 7'b1111111; // Blank display
				display_dataD = 7'b1111111; // Blank display
				display_dataE = 7'b1111111; // Blank display
				display_dataF = bcd_to_7seg(bcd[23:20]);
				display_mux <= 3'b000;
        end
        default: begin
            display_dataA = 7'b1111111; // Blank display
            display_dataB = 7'b1111111; // Blank display
				display_dataC = 7'b1111111; // Blank display
				display_dataD = 7'b1111111; // Blank display
				display_dataE = 7'b1111111; // Blank display
				display_dataF = 7'b1111111; // Blank display
				display_mux <= 3'b000;
        end
    endcase
end

// Binary to 7-segment decoder
function [6:0] bcd_to_7seg;
input [3:0] bcd;
begin
    case (bcd)
        4'h0: bcd_to_7seg = 7'b1000000; 
        4'h1: bcd_to_7seg = 7'b1111001; 
        4'h2: bcd_to_7seg = 7'b0100100; 
        4'h3: bcd_to_7seg = 7'b0110000; 
        4'h4: bcd_to_7seg = 7'b0011001; 
        4'h5: bcd_to_7seg = 7'b0010010; 
        4'h6: bcd_to_7seg = 7'b0000010; 
        4'h7: bcd_to_7seg = 7'b1111000; 
        4'h8: bcd_to_7seg = 7'b0000000; 
        4'h9: bcd_to_7seg = 7'b0010000; 
		  4'hA: bcd_to_7seg = 7'b0001000;
		  4'hB: bcd_to_7seg = 7'b0000011;
		  4'hC: bcd_to_7seg = 7'b1000110;
		  4'hD: bcd_to_7seg = 7'b0100001;
		  4'hE: bcd_to_7seg = 7'b0000110;
		  4'hF: bcd_to_7seg = 7'b0001110;
        default: bcd_to_7seg = 7'b1111111;
    endcase
end
endfunction

endmodule

