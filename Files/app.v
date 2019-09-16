//----------------------------------------------------------------------------
//-- Aplicación de recepción imagen YUV desde OV7670 para hacerle un detector
//-- de bordes (filtro Solbel) y enviar el resultado como archivo binario a PC
//----------------------------------------------------------------------------
//-- September 2019. Written by Ivan Rios
//-- GPL license
//----------------------------------------------------------------------------
`include "baudgen.vh"

//-- Modulo Principal
module app (input wire clk,  //-- Reloj del sistema
                input wire rst_hw,  //-- Señal de DTR
                input wire PCLK,  //-- Señal de DTR
                input wire Href,  //-- Señal de DTR
                input wire VSYNC,  //-- Señal de DTR
                input wire [7:0] in_pixel,  //-- Señal de data
                output wire clk_ext,   //-- Salida de datos
                output wire tx   //-- Salida de datos serie
               );
       

//-- Velocidad a la que hacer las pruebas
parameter BAUD = `B12Mbauds;

parameter AW = 7;
parameter DW = 8;

parameter WIDTH_SOBEL = 318; // Ancho de pixeles de salida al aplicar el filtro sobel

//-- Registros Intermedios
reg pixel_luminancia=0;
reg PCLK_ant=0;

reg dtr_ant=0;
reg rst=1;
reg par=0;

assign clk_ext = clk;
    
// Proceso de inicialización	
initial begin 
	rst<=1;
end

always @(posedge clk) begin
  rst<=0;
	
  if(rst_hw) begin
	rst<=1;
  end

end

// Solo activa la recepción los píxeles impares (luminancias)
always @(posedge clk) begin
  if(rst || VSYNC || !Href) begin
	pixel_luminancia<=0;
	PCLK_ant<=PCLK;
	par<=0;
  end
  
  else begin
	PCLK_ant<=PCLK;
	
	if(!PCLK_ant && PCLK && Href && !VSYNC) begin
	pixel_luminancia<= 0;
		par<= (par) ? 0 : 1 ;
		if(!par) begin
			pixel_luminancia<= 1;
		end
	end
  end
	
end
//------------------------------------------------
//-- 	RUTA DE DATOS
//------------------------------------------------
wire [7:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11;

wire [AW-1:0]  addr_write0,addr_write1,addr_write2,
			   addr_write3,addr_write4,addr_write5,
			   addr_write6,addr_write7,addr_write8,
			   addr_write9,addr_write10,addr_write11;
		   
wire [AW-1:0]  addr_read0,addr_read1,addr_read2,
			   addr_read3,addr_read4,addr_read5,
			   addr_read6,addr_read7,addr_read8,
			   addr_read9,addr_read10,addr_read11;


wire [11:0] out_rw;

//----------------------------------------------- control_RAM

control_RAM
 control_RAM(
	.clk(clk),
	.rst(rst),
		
	.in_pixel(in_pixel),		
	.PCLK(pixel_luminancia),
	.Href(Href),
	.VSYNC(VSYNC),
    
    .r0(r0), .r1(r1), .r2(r2),
    .r3(r3), .r4(r4), .r5(r5),
    .r6(r6), .r7(r7), .r8(r8),
    .r9(r9), .r10(r10), .r11(r11),
    
    .addr_write0(addr_write0), .addr_write1(addr_write1),  .addr_write2(addr_write2),
    .addr_write3(addr_write3), .addr_write4(addr_write4),  .addr_write5(addr_write5),
    .addr_write6(addr_write6), .addr_write7(addr_write7),  .addr_write8(addr_write8),
    .addr_write9(addr_write9), .addr_write10(addr_write10),.addr_write11(addr_write11),
    
    .addr_read0(addr_read0), .addr_read1(addr_read1),  .addr_read2(addr_read2),
    .addr_read3(addr_read3), .addr_read4(addr_read4),  .addr_read5(addr_read5),
    .addr_read6(addr_read6), .addr_read7(addr_read7),  .addr_read8(addr_read8),
    .addr_read9(addr_read9), .addr_read10(addr_read10),.addr_read11(addr_read11),
    
    .out_rw(out_rw),
    
    .RAM_flag(RAM_flag)
  );

wire [7:0] ro0,ro1,ro2,ro3,ro4,ro5,
		   ro6,ro7,ro8,ro9,ro10,ro11;
//----------------------------------------------- RAMs
RAMs #(.AW(AW), .DW(DW))
	RAMs(
    .clk(clk),
    .rst(rst),
    .RAM_flag(RAM_flag),
    .VSYNC(VSYNC),
    .Href(Href),
    
    .r0(r0), .r1(r1), .r2(r2),
    .r3(r3), .r4(r4), .r5(r5),
    .r6(r6), .r7(r7), .r8(r8),
    .r9(r9), .r10(r10), .r11(r11),
    
    .addr_write0(addr_write0), .addr_write1(addr_write1),  .addr_write2(addr_write2),
    .addr_write3(addr_write3), .addr_write4(addr_write4),  .addr_write5(addr_write5),
    .addr_write6(addr_write6), .addr_write7(addr_write7),  .addr_write8(addr_write8),
    .addr_write9(addr_write9), .addr_write10(addr_write10),.addr_write11(addr_write11),
    
    .addr_read0(addr_read0), .addr_read1(addr_read1),  .addr_read2(addr_read2),
    .addr_read3(addr_read3), .addr_read4(addr_read4),  .addr_read5(addr_read5),
    .addr_read6(addr_read6), .addr_read7(addr_read7),  .addr_read8(addr_read8),
    .addr_read9(addr_read9), .addr_read10(addr_read10),.addr_read11(addr_read11),
    
    
    .in_rw(out_rw),
    .mask_flag(mask_flag),
    
    .ro0(ro0), .ro1(ro1), .ro2(ro2),
    .ro3(ro3), .ro4(ro4), .ro5(ro5),
    .ro6(ro6), .ro7(ro7), .ro8(ro8),
    .ro9(ro9), .ro10(ro10), .ro11(ro11)
  );
			
  
  

//------------------------------- mask_control

wire [3:0] order;
wire sobel_pulse;

mask_control  #(.WIDTH_SOBEL(WIDTH_SOBEL))
	mask_control(
    .clk(clk),
    .rst(rst),
    .mask_flag(mask_flag),
	.Href(Href),
	.VSYNC(VSYNC),
    .order(order),
    .sobel_pulse(sobel_pulse)
  );
  
  

//------------------------------- pixel_order
					 
wire [7:0]p0,p1,p2,
		  p3,   p5,
		  p6,p7,p8;
			
pixel_order pixel_order(
    .clk(clk),
    .rst(rst),
    .order(order),
    
    .ro0(ro0), .ro1(ro1) ,.ro2(ro2),
	.ro3(ro3), .ro4(ro4) ,.ro5(ro5),
	.ro6(ro6), .ro7(ro7) ,.ro8(ro8),
	.ro9(ro9), .ro10(ro10),.ro11(ro11),
	
	.p0(p0), .p1(p1), .p2(p2),
	.p3(p3), 	  	  .p5(p5),
	.p6(p6), .p7(p7), .p8(p8)
  );
  
  
wire [7:0]  out;
sobel sobel(
    .p0(p0), .p1(p1) ,.p2(p2),
	.p3(p3),            .p5(p5),
	.p6(p6), .p7(p7) ,.p8(p8),
	
	.out(out)
  );
  
wire uart_flag;

control_uart #(.BAUD(BAUD))
  control_uart (
    .clk(clk),
    .rst(rst),
    .dtr(sobel_pulse),
    .VSYNC(VSYNC),
    .data(out),
    .tx(tx)
 );
 

endmodule




