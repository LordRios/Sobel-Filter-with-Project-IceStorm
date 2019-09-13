//-------------------------------------------------------------------
//-- buffer_tb.v
//-- Banco de pruebas para buffer serie, implementado con
//-- una memoria ram generica
//-------------------------------------------------------------------
//-- BQ November 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module imagen_uart_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;
reg rst_hw = 0;
	
reg [7:0] in_pixel=0; 

reg Href = 0;
reg PCLK = 0;
reg VSYNC = 0;
wire [2:0] sel_leds;
wire tx;
wire ready;
wire [7:0] leds;
//-- Instanciar el componente

imagen_uart imagen_uart(
    .clk(clk),
    .rst_hw(rst_hw),
	
	.PCLK(PCLK),
	.Href(Href),
	.VSYNC(VSYNC),
    
	.sel_leds(sel_leds),
	.in_pixel(in_pixel),
	
	.leds(leds),
	.tx(tx)
  );

  
localparam Tmedio_1Mhz = 12; // 1MHz

localparam Tmedios_PCLK = Tmedio_1Mhz*4; // 250kHz
localparam T_PCLK = Tmedios_PCLK*2;

//-- Generador de reloj. 
always #1 clk = ~clk; // 12MHz

//-- Generador de reloj.
always #Tmedios_PCLK PCLK = ~PCLK;

//-- Proceso al inicio
initial begin

    $dumpfile("imagen_uart_tb.vcd");    
    $dumpvars(0, imagen_uart_tb);
    
   Href <= 0;
   VSYNC <= 1;
   
    rst_hw <= 1;
   # 30  rst_hw <= 0;
   
   
  #(T_PCLK*20) VSYNC <= 0;
     
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1; 
   
   
      in_pixel <= 0;
   #T_PCLK in_pixel <= 1;
   #T_PCLK in_pixel <= 2;
   #T_PCLK in_pixel <= 3;
   #T_PCLK in_pixel <= 4;
   #T_PCLK in_pixel <= 5;
   #T_PCLK in_pixel <= 6;
   #T_PCLK in_pixel <= 7;
   #T_PCLK in_pixel <= 8;
   #T_PCLK in_pixel <= 9;
     
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1; 
   
   
      in_pixel <= 10;
   #T_PCLK in_pixel <= 11;
   #T_PCLK in_pixel <= 12;
   #T_PCLK in_pixel <= 13;
   #T_PCLK in_pixel <= 14;
   #T_PCLK in_pixel <= 15;
   #T_PCLK in_pixel <= 16;
   #T_PCLK in_pixel <= 17;
   #T_PCLK in_pixel <= 18;
   #T_PCLK in_pixel <= 19;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 20;
   #T_PCLK in_pixel <= 21;
   #T_PCLK in_pixel <= 22;
   #T_PCLK in_pixel <= 23;
   #T_PCLK in_pixel <= 24;
   #T_PCLK in_pixel <= 25;
   #T_PCLK in_pixel <= 26;
   #T_PCLK in_pixel <= 27;
   #T_PCLK in_pixel <= 28;
   #T_PCLK in_pixel <= 29;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 30;
   #T_PCLK in_pixel <= 31;
   #T_PCLK in_pixel <= 32;
   #T_PCLK in_pixel <= 33;
   #T_PCLK in_pixel <= 34;
   #T_PCLK in_pixel <= 35;
   #T_PCLK in_pixel <= 36;
   #T_PCLK in_pixel <= 37;
   #T_PCLK in_pixel <= 38;
   #T_PCLK in_pixel <= 39;
   
   # T_PCLK Href <= 0;
   
   # T_PCLK VSYNC <= 1;
   # (T_PCLK*20)  VSYNC <= 0;
   
   # (T_PCLK*20) Href <= 1;
   
      in_pixel <= 40;
   #T_PCLK in_pixel <= 41;
   #T_PCLK in_pixel <= 42;
   #T_PCLK in_pixel <= 43;
   #T_PCLK in_pixel <= 44;
   #T_PCLK in_pixel <= 45;
   #T_PCLK in_pixel <= 46;
   #T_PCLK in_pixel <= 47;
   #T_PCLK in_pixel <= 48;
   #T_PCLK in_pixel <= 49;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 0;
   #T_PCLK in_pixel <= 1;
   #T_PCLK in_pixel <= 2;
   #T_PCLK in_pixel <= 3;
   #T_PCLK in_pixel <= 4;
   #T_PCLK in_pixel <= 5;
   #T_PCLK in_pixel <= 6;
   #T_PCLK in_pixel <= 7;
   #T_PCLK in_pixel <= 8;
   #T_PCLK in_pixel <= 9;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1; 
   
   
      in_pixel <= 10;
   #T_PCLK in_pixel <= 11;
   #T_PCLK in_pixel <= 12;
   #T_PCLK in_pixel <= 13;
   #T_PCLK in_pixel <= 14;
   #T_PCLK in_pixel <= 15;
   #T_PCLK in_pixel <= 16;
   #T_PCLK in_pixel <= 17;
   #T_PCLK in_pixel <= 18;
   #T_PCLK in_pixel <= 19;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 20;
   #T_PCLK in_pixel <= 21;
   #T_PCLK in_pixel <= 22;
   #T_PCLK in_pixel <= 23;
   #T_PCLK in_pixel <= 24;
   #T_PCLK in_pixel <= 25;
   #T_PCLK in_pixel <= 26;
   #T_PCLK in_pixel <= 27;
   #T_PCLK in_pixel <= 28;
   #T_PCLK in_pixel <= 29;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 30;
   #T_PCLK in_pixel <= 31;
   #T_PCLK in_pixel <= 32;
   #T_PCLK in_pixel <= 33;
   #T_PCLK in_pixel <= 34;
   #T_PCLK in_pixel <= 35;
   #T_PCLK in_pixel <= 36;
   #T_PCLK in_pixel <= 37;
   #T_PCLK in_pixel <= 38;
   #T_PCLK in_pixel <= 39;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 40;
   #T_PCLK in_pixel <= 41;
   #T_PCLK in_pixel <= 42;
   #T_PCLK in_pixel <= 43;
   #T_PCLK in_pixel <= 44;
   #T_PCLK in_pixel <= 45;
   #T_PCLK in_pixel <= 46;
   #T_PCLK in_pixel <= 47;
   #T_PCLK in_pixel <= 48;
   #T_PCLK in_pixel <= 49;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 0;
   #T_PCLK in_pixel <= 1;
   #T_PCLK in_pixel <= 2;
   #T_PCLK in_pixel <= 3;
   #T_PCLK in_pixel <= 4;
   #T_PCLK in_pixel <= 5;
   #T_PCLK in_pixel <= 6;
   #T_PCLK in_pixel <= 7;
   #T_PCLK in_pixel <= 8;
   #T_PCLK in_pixel <= 9;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1; 
   
   
      in_pixel <= 10;
   #T_PCLK in_pixel <= 11;
   #T_PCLK in_pixel <= 12;
   #T_PCLK in_pixel <= 13;
   #T_PCLK in_pixel <= 14;
   #T_PCLK in_pixel <= 15;
   #T_PCLK in_pixel <= 16;
   #T_PCLK in_pixel <= 17;
   #T_PCLK in_pixel <= 18;
   #T_PCLK in_pixel <= 19;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 20;
   #T_PCLK in_pixel <= 21;
   #T_PCLK in_pixel <= 22;
   #T_PCLK in_pixel <= 23;
   #T_PCLK in_pixel <= 24;
   #T_PCLK in_pixel <= 25;
   #T_PCLK in_pixel <= 26;
   #T_PCLK in_pixel <= 27;
   #T_PCLK in_pixel <= 28;
   #T_PCLK in_pixel <= 29;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 30;
   #T_PCLK in_pixel <= 31;
   #T_PCLK in_pixel <= 32;
   #T_PCLK in_pixel <= 33;
   #T_PCLK in_pixel <= 34;
   #T_PCLK in_pixel <= 35;
   #T_PCLK in_pixel <= 36;
   #T_PCLK in_pixel <= 37;
   #T_PCLK in_pixel <= 38;
   #T_PCLK in_pixel <= 39;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 40;
   #T_PCLK in_pixel <= 41;
   #T_PCLK in_pixel <= 42;
   #T_PCLK in_pixel <= 43;
   #T_PCLK in_pixel <= 44;
   #T_PCLK in_pixel <= 45;
   #T_PCLK in_pixel <= 46;
   #T_PCLK in_pixel <= 47;
   #T_PCLK in_pixel <= 48;
   #T_PCLK in_pixel <= 49;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 0;
   #T_PCLK in_pixel <= 1;
   #T_PCLK in_pixel <= 2;
   #T_PCLK in_pixel <= 3;
   #T_PCLK in_pixel <= 4;
   #T_PCLK in_pixel <= 5;
   #T_PCLK in_pixel <= 6;
   #T_PCLK in_pixel <= 7;
   #T_PCLK in_pixel <= 8;
   #T_PCLK in_pixel <= 9;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1; 
   
   
      in_pixel <= 10;
   #T_PCLK in_pixel <= 11;
   #T_PCLK in_pixel <= 12;
   #T_PCLK in_pixel <= 13;
   #T_PCLK in_pixel <= 14;
   #T_PCLK in_pixel <= 15;
   #T_PCLK in_pixel <= 16;
   #T_PCLK in_pixel <= 17;
   #T_PCLK in_pixel <= 18;
   #T_PCLK in_pixel <= 19;
   
   # T_PCLK Href <= 0;
   
   # T_PCLK VSYNC <= 1;
   # (T_PCLK*20)  VSYNC <= 0;
   
   # (T_PCLK*20) Href <= 1;
   
   
      in_pixel <= 20;
   #T_PCLK in_pixel <= 21;
   #T_PCLK in_pixel <= 22;
   #T_PCLK in_pixel <= 23;
   #T_PCLK in_pixel <= 24;
   #T_PCLK in_pixel <= 25;
   #T_PCLK in_pixel <= 26;
   #T_PCLK in_pixel <= 27;
   #T_PCLK in_pixel <= 28;
   #T_PCLK in_pixel <= 29;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 30;
   #T_PCLK in_pixel <= 31;
   #T_PCLK in_pixel <= 32;
   #T_PCLK in_pixel <= 33;
   #T_PCLK in_pixel <= 34;
   #T_PCLK in_pixel <= 35;
   #T_PCLK in_pixel <= 36;
   #T_PCLK in_pixel <= 37;
   #T_PCLK in_pixel <= 38;
   #T_PCLK in_pixel <= 39;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
      in_pixel <= 40;
   #T_PCLK in_pixel <= 41;
   #T_PCLK in_pixel <= 42;
   #T_PCLK in_pixel <= 43;
   #T_PCLK in_pixel <= 44;
   #T_PCLK in_pixel <= 45;
   #T_PCLK in_pixel <= 46;
   #T_PCLK in_pixel <= 47;
   #T_PCLK in_pixel <= 48;
   #T_PCLK in_pixel <= 49;
   
   # T_PCLK Href <= 0;
   # T_PCLK Href <= 1;
   
   
   
  $finish;
end

endmodule
