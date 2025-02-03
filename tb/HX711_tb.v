`timescale 1ns / 1ps

module HX711_tb;

    // Declarar las señales
    reg clk;               // Reloj de entrada
    reg rst;               // Señal de reset
    reg DOUT;              // Pin de salida de datos del HX711
	 wire en;
    wire [23:0] data_out;  // Datos crudos leídos del HX711
    wire PD_SCK;           // Señal del reloj PD_SCK
	 wire [6:0] segA, segB, segC, segD, segE, segF;

    // Instanciar el módulo HX711
    HX711 dut (
        .clk(clk),
        .rst(rst),
        .DOUT(DOUT),
		  .en(en),
        .data_out(data_out),
        .PD_SCK(PD_SCK),
		  .segA(segA),
		  .segB(segB),
		  .segC(segC),
		  .segD(segD),
		  .segE(segE),
		  .segF(segF)
    );
    // Generar el reloj con un periodo de 20ns (50MHz)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Toggle cada 10ns para simular un reloj de 50 MHz
    end

    // Proceso de prueba
    initial begin
   rst = 0;
   DOUT = 1;
   #100;
   rst = 1;
	#1900;
	
	DOUT = 0; //START DEPENDS ON PULSE FREQ
	#2200;
	
	DOUT = 1; //1		
	#4200;
	DOUT = 0;
	#4200
	DOUT = 1;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0; //10
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0; //24 FINAL = 1011-0010-1010-0011-0111-1010
	#4200;
	
	DOUT = 1;
	#10_000;
	
	DOUT = 0; //START
	#2200;
	
	DOUT = 0; //1		
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0; //4
	#4200;
	DOUT = 1; 
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0; //8
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1; 
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0; //12
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0; 
	#4200;
	DOUT = 1; //16
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1; //20
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1; //24 FINAL = 0110-1000-0110-1001-1011-0011
	#4200;
	
	DOUT = 1;
	#10_000;
	
	DOUT = 0; //START
	#2000;
	
	DOUT = 1; //1		
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1; //4
	#4200;
	DOUT = 1; 
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0; //8
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1; 
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0; //12
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0; 
	#4200;
	DOUT = 1; //16
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0; //20
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1; //24 FINAL = 1111-1010-1100-0001-1000-0011
	#4200;

	
	DOUT = 1;
	#10_000;
	
	DOUT = 0; //START
	#2000;
	
	DOUT = 0; //1		
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0; //4
	#4200;
	DOUT = 0; 
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0; //8
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1; 
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0; //12
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1; 
	#4200;
	DOUT = 1; //16
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1; //20
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1; //24 FINAL = 0000-0100-0110-0111-1101-0001
	#4200;

	
	DOUT = 1;
	#10_000;
	
	DOUT = 0; //START
	#2000;
	
	DOUT = 0; //1		
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0; //4
	#4200;
	DOUT = 1; 
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0; //8
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1; 
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0; //12
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0; 
	#4200;
	DOUT = 1; //16
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1; //20
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 0;
	#4200;
	DOUT = 1;
	#4200;
	DOUT = 1; //24 FINAL = 0110-1000-0110-1001-1011-0011
	#4200;


	 
	// Repetir para 24 bits

	  // Finalizar la simulación después de un tiempo
    end


endmodule
