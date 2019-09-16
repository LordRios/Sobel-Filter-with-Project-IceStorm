//-------------------------------------------------------------------
//-- buffer_tb.v
//-- Banco de pruebas para buffer serie, implementado con
//-- una memoria ram generica
//-------------------------------------------------------------------
//-- BQ November 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module app_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;
reg rst_hw = 0;
	
reg [7:0] in_pixel=0; 

reg Href = 0;
reg PCLK = 0;
reg VSYNC = 0;
wire [7:0]  out;
wire [7:0]  leds;
wire tx;
wire clk_ext;

parameter WIDTH_SOBEL = 8; //318 para el modo ejecución
//-- Instanciar el componente
app   #(.WIDTH_SOBEL(WIDTH_SOBEL))
app(
    .clk(clk),
    .rst_hw(rst_hw),
    
	.in_pixel(in_pixel),
	
	.PCLK(PCLK),
	.Href(Href),
	.VSYNC(VSYNC),
	
	.clk_ext(clk_ext),
	.tx(tx)
  );

localparam Tmedios_PCLK = 30; //real 60
localparam T_PCLK = Tmedios_PCLK*4; //x2 para ser un ciclo y x2 para Y-UV
//-- Generador de reloj. Periodo 4 unidades
always #1 clk = ~clk;

//-- Generador de reloj. Periodo 12 unidades
always #Tmedios_PCLK PCLK = ~PCLK;

localparam T_p = T_PCLK; 

localparam T_upHREF = T_p*320;
localparam T_downHREF = T_PCLK; //--localparam T_downHREF = T_p*72;

localparam T_line = T_p*392;

localparam T_upVSYNC = T_line*3;
localparam T_downVSYNC1 = T_line*17;
localparam T_downVSYNC2 = T_line*10;


//-- Proceso al inicio
initial begin

    $dumpfile("app_tb.vcd");    
    $dumpvars(0, app);
    
   Href <= 0;
   VSYNC <= 0;
   
    rst_hw <= 1;
   # T_PCLK  rst_hw <= 0;
     
   # T_downHREF Href <= 1; 
   
   
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
   # T_downHREF Href <= 1; 
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   
   
   	     		VSYNC <= 1;
   # 500  VSYNC <= 0;
   
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
   # T_downHREF Href <= 1; 
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1; 
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1; 
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   
   
   	     		VSYNC <= 1;
   # 500  VSYNC <= 0;
   
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
   # T_downHREF Href <= 1; 
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1; 
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
   
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
   # T_downHREF Href <= 1;
   
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
   # T_downHREF Href <= 1; 
   
   
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
   
   # 10 Href <= 0;
   
   # 100
   
  $finish;
end

endmodule
