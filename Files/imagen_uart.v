//----------------------------------------------------------------------------
//-- Recepción de imagen YUV 4:2:2 desde OV7670 y envío de la imagen en 
//-- blanco y negro
//----------------------------------------------------------------------------
//-- September 2019. Written by Ivan Rios
//-- Base design by Juan Gonzalez (https://github.com/Obijuan/open-fpga-verilog-tutorial/wiki)
//-- GPL license
//----------------------------------------------------------------------------
`include "baudgen.vh"


module imagen_uart (input wire clk,  //-- Reloj del sistema
                input wire rst_hw,  //-- Señal de DTR
                input wire PCLK,  //-- Señal de DTR
                input wire Href,  //-- Señal de DTR
                input wire VSYNC,  //-- Señal de DTR
                input wire [2:0] sel_leds,  //-- Señal de data
                input wire [7:0] in_pixel,  //-- Señal de data
                output wire [7:0] leds,  //-- Señal de data
                output wire clk_ext,   //-- Salida de datos
                output wire PCLK_ext,   //-- Salida de datos
                output wire VSYNC_ext,   //-- Salida de datos serie
                output wire tx   //-- Salida de datos serie
               );
       
  assign VSYNC_ext = VSYNC;
  assign PCLK_ext = PCLK;
  

//-- Velocidad de la UART
parameter BAUD = `B12Mbauds;

//-- Señal de listo del transmisor serie
wire ready;

//-- Dato a transmitir (normal y registrado)
reg state_dtr=0;
reg PCLK_ant=0;

reg dtr_ant=0;
reg rst=1;
reg par=0;

assign clk_ext = clk;
//--Iniciador
    
initial begin 
	rst<=1;
end

always @(posedge clk) begin
  rst<=0;
	
  if(rst_hw) begin
	rst<=1;
  end

end

//-- Selecciona cada byte impar (luminancia) para ser enviado
always @(posedge clk) begin
  if(rst || VSYNC || !Href) begin
	state_dtr<=0;
	PCLK_ant<=PCLK;
	par<=0;
  end
  
  else begin
	PCLK_ant<=PCLK;
	state_dtr<= 0;
	
	if(!PCLK_ant && PCLK && Href && !VSYNC) begin
		par<= (par) ? 0 : 1 ;
		if(!par) begin
			state_dtr<= 1;
		end
	end
  end
	
end

//------------------------------------------------
//-- 	RUTA DE DATOS
//------------------------------------------------

//-- Instanciar la Unidad de transmision
control_uart #(.BAUD(BAUD))
  control_uart (
    .clk(clk),
    .rst(rst),
    .dtr(state_dtr),
    .VSYNC(VSYNC),
    .data(in_pixel),
    .ready(ready),
    .tx(tx)
 );

endmodule




