module mod_m_counter
	#(
		parameter N=2, //number of bits in counter
					 M=3  //Count number
	)
	(
		input wire clk, rst,
		output wire max_tick,
		output wire [N-1:0] q
	);
	
	reg [N-1:0] r_reg;
	wire [N-1:0] r_next;
	
	always @(posedge clk or negedge rst) begin
		if(~rst)
			r_reg <= 0;
		else
			r_reg <= r_next;
	end
	
	assign r_next = (r_reg == (M - 1'b1)) ? 0 : r_reg + 1'b1;
	assign q = r_reg;
	assign max_tick = (r_reg == (M - 1'b1)) ? 1'b1 : 1'b0;

endmodule
