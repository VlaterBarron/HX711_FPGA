module HX711(
	input wire clk, rst, DOUT,
	output wire PD_SCK, en,
	output wire [23:0] data_out,
	output wire [6:0] segA, segB, segC, segD, segE, segF
);

	wire max_tick;
	parameter ST = 1, FFH = 500, EP = 1, NBITS = 5, COUNT = 13, TC=10;   //FFH = 50_000_000, COUNT = 100 -- 50MHz/50,000*16 = 63
	
	HX711_rx #(.SLEEP_TIME(ST), .FPGA_FREQ_HZ(FFH), .EXTRA_PULSES(EP), .TICK_COUNTER(TC)) hx711_rx(
		.clk(clk),
		.rst(rst),
		.en(en),
		.s_tick(max_tick),
		.DOUT(DOUT),
		.data_out(data_out),
		.PD_SCK(PD_SCK)
	);
	
	mod_m_counter #(.N(NBITS), .M(COUNT)) counter( //Clock/BR*16 -> 50Mhz/9600*16 = 326 --> 20 us = 50,000 Hz == 50,000 bauds
		.clk(clk),
		.rst(rst),
		.max_tick(max_tick),
		.q()
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
