module HX711(
	input wire clk, rst, DOUT,
	output wire PD_SCK, en,
	output wire [23:0] data_out,
	output wire [6:0] segA, segB, segC, segD, segE, segF
);
	
	HX711_rx hx711_rx(
		.clk(clk),
		.rst(rst),
		.en(en),
		.DOUT(DOUT),
		.data_out(data_out),
		.PD_SCK(PD_SCK)
	);
	
	bcd_to_7seg_mux segment_mux(
		.clk(clk),
		.bcd(data_out),
		.segA(segA),
		.segB(segB),
		.segC(segC),
		.segD(segD),
		.segE(segE),
		.segF(segF)
	);

endmodule
