module HX711_rx 
	#(
		parameter SLEEP_TIME=10,
					 FPGA_FREQ_HZ = 50,
					 EXTRA_PULSES = 1,
					 TICK_COUNTER = 10
	)
	(
		 input wire clk,           // System clock
		 input wire rst,           // Reset signal
		 input wire DOUT,          // Serial Data Output Pin from HX711
		 input wire s_tick,			// Input signal from mod_m_counter
		 output wire en,				// Output to kill HX711 power
		 output wire [23:0] data_out, // The raw data from the HX711
		 output wire PD_SCK         // Power Down and Serial Clock Output Pin
	);
	
	localparam [2:0] IDLE = 3'b000, READY = 3'b001, PULSE = 3'b010, STOP = 3'b011, SLEEP = 3'b100; 
	
	parameter NUMBER_OF_PULSES = 24;
	
	reg [2:0] state, next_state;
	reg [3:0] s_tick_counter, next_s_tick_counter;
	reg [4:0] data_counter, next_data_counter;
	reg [23:0] data_out_reg, next_data_out_reg;
	reg [23:0] data_out_aux = 0;
	reg [7:0] bit_count, next_bit_count;
	reg [37:0] seconds_count, next_seconds_count;
	
	reg PD_SCK_reg = 0;
	reg en_reg, next_en_reg;
	  
	 always @(posedge clk or negedge rst) begin
			if(!rst) begin
				state <= 0;
				data_out_reg <= 0;
				bit_count <= 0;
				seconds_count <= 0;
				s_tick_counter <= 0;
				data_counter <= 0;
				en_reg <= 1'b1;
			end else begin
				state <= next_state;
				data_out_reg <= next_data_out_reg;
				bit_count <= next_bit_count;
				en_reg <= next_en_reg;
				seconds_count <= next_seconds_count;
				s_tick_counter <= next_s_tick_counter;
				data_counter <= next_data_counter;
			end
	  end
	  
	  always @(*) begin
	  next_state = state;
	  next_en_reg = en_reg;
	  next_seconds_count = seconds_count;
	  next_s_tick_counter = s_tick_counter;
	  next_data_counter = data_counter;
	  next_data_out_reg = data_out_reg;
	  next_bit_count = bit_count;
	  
	case(state)
		IDLE: 
			if(~DOUT) 
				begin
					next_state = READY;
					next_s_tick_counter = 0;
				end
				
			
			READY:
			if(s_tick) 
				if(s_tick_counter == 8) 
					begin
						next_state = PULSE;
						next_data_out_reg = 0;
						PD_SCK_reg = 1'b1;
						next_s_tick_counter = 0;
					end
				else
					next_s_tick_counter = s_tick_counter + 1'b1;
			
			
			PULSE: 
				if(s_tick)
					if(s_tick_counter == 7)
						begin
							PD_SCK_reg = ~PD_SCK_reg;
							next_s_tick_counter = s_tick_counter + 1'b1;
							next_data_out_reg <= {data_out_reg[22:0], DOUT}; 
							if(bit_count == (NUMBER_OF_PULSES - 1'b1)) 
								begin
									next_bit_count = 0;
									next_s_tick_counter = 0;
									next_state = STOP;
								end
							else
								next_bit_count = bit_count + 1'b1;
						end
					else if(s_tick_counter == 15) 
						begin
							next_s_tick_counter = 0;
							PD_SCK_reg = ~PD_SCK_reg;
						end
					else
						next_s_tick_counter = s_tick_counter + 1'b1;
				
			
			STOP: 
				if(s_tick)
					if(s_tick_counter == 7)
						begin
							PD_SCK_reg = ~PD_SCK_reg;
							next_s_tick_counter = s_tick_counter + 1'b1;
						end
					else if(s_tick_counter == 15) 
						begin
							next_s_tick_counter = 0;
							PD_SCK_reg = ~PD_SCK_reg;
							if(bit_count == (EXTRA_PULSES - 1'b1))
								begin
									data_out_aux = data_out_reg;
									next_bit_count = 0;
									next_state = SLEEP;
								end
							else
								next_bit_count = bit_count + 1'b1;
						end
					else
						next_s_tick_counter = s_tick_counter + 1'b1;
				
			
			SLEEP: begin
				next_en_reg = 0;
				PD_SCK_reg = 0;
				if(seconds_count == ((FPGA_FREQ_HZ * SLEEP_TIME) - 1'b1)) begin
					next_seconds_count = 0;
					next_en_reg = 1'b1;
					next_state = IDLE;
				end else begin
					next_seconds_count = next_seconds_count + 1'b1;
					next_state = SLEEP;
				end
			end

	endcase
	  
end

	assign data_out = data_out_aux;
	assign en = en_reg;
	assign PD_SCK = PD_SCK_reg;
	  
endmodule
