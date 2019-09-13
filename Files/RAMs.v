//----------------------------------------------------------------------------
//-- Intanciación de las 12 RAMs necesarias y una cuenta atrás para el inicio
//-- del envío después de recibir la 3a fila
//----------------------------------------------------------------------------
//-- September 2019. Written by Ivan Rios
//-- GPL license
//----------------------------------------------------------------------------
module RAMs #(           
         parameter AW = 7) //-- Numero de bits de la dirección de la memoria
         
	(input wire clk,
	input wire rst,
	input wire RAM_flag,
	input wire VSYNC,
	input wire Href,
					 
	input wire [7:0] r0,r1,r2,
					  r3,r4,r5,
					  r6,r7,r8,
					  r9,r10,r11,
					  
	input wire[6:0] addr_write0,addr_write1,addr_write2,
					addr_write3,addr_write4,addr_write5,
					addr_write6,addr_write7,addr_write8,
					addr_write9,addr_write10,addr_write11,
					  
	input wire[6:0] addr_read0,addr_read1,addr_read2,
					addr_read3,addr_read4,addr_read5,
					addr_read6,addr_read7,addr_read8,
					addr_read9,addr_read10,addr_read11,  
	
	input wire [11:0] in_rw,
	
	output wire mask_flag,
	
	output wire [7:0] ro0,ro1,ro2,
					  ro3,ro4,ro5,
					  ro6,ro7,ro8,
					  ro9,ro10,ro11
	);

//-- Numero de bits de los datos almacenados en memoria
parameter DW = 8;

reg reg_mask_flag=0;
reg VSYNC_ant=0;
reg Href_ant=0;
reg [1:0]first_row=3;

always @(posedge clk) begin
  if (rst) begin
	VSYNC_ant<=0;
	reg_mask_flag<=0;
	first_row<=3;
  end
	
  else begin
	VSYNC_ant<=VSYNC;
	Href_ant<=Href;
	reg_mask_flag<=RAM_flag;
	
	if (!VSYNC_ant && VSYNC)
		first_row<=3;
	
	if (first_row && Href_ant && !Href)
		first_row<=first_row-1;
	
	else if (first_row)
		reg_mask_flag<=0;
	
  end
end

assign mask_flag=reg_mask_flag;

RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM0 (
        .clk(clk),
        .addr_write(addr_write0),
        .addr_read(addr_read0),
        .data_in(r0),
        .data_out(ro0),
        .rw(in_rw[0])
      );

RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM1 (
        .clk(clk),
        .addr_write(addr_write1),
        .addr_read(addr_read1),
        .data_in(r1),
        .data_out(ro1),
        .rw(in_rw[1])
      );

RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM2 (
        .clk(clk),
        .addr_write(addr_write2),
        .addr_read(addr_read2),
        .data_in(r2),
        .data_out(ro2),
        .rw(in_rw[2])
      );

RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM3 (
        .clk(clk),
        .addr_write(addr_write3),
        .addr_read(addr_read3),
        .data_in(r3),
        .data_out(ro3),
        .rw(in_rw[3])
      );


RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM4 (
        .clk(clk),
        .addr_write(addr_write4),
        .addr_read(addr_read4),
        .data_in(r4),
        .data_out(ro4),
        .rw(in_rw[4])
      );


RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM5 (
        .clk(clk),
        .addr_write(addr_write5),
        .addr_read(addr_read5),
        .data_in(r5),
        .data_out(ro5),
        .rw(in_rw[5])
      );

RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM6 (
        .clk(clk),
        .addr_write(addr_write6),
        .addr_read(addr_read6),
        .data_in(r6),
        .data_out(ro6),
        .rw(in_rw[6])
      );

RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM7 (
        .clk(clk),
        .addr_write(addr_write7),
        .addr_read(addr_read7),
        .data_in(r7),
        .data_out(ro7),
        .rw(in_rw[7])
      );

RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM8 (
        .clk(clk),
        .addr_write(addr_write8),
        .addr_read(addr_read8),
        .data_in(r8),
        .data_out(ro8),
        .rw(in_rw[8])
      );

RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM9 (
        .clk(clk),
        .addr_write(addr_write9),
        .addr_read(addr_read9),
        .data_in(r9),
        .data_out(ro9),
        .rw(in_rw[9])
      );


RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM10 (
        .clk(clk),
        .addr_write(addr_write10),
        .addr_read(addr_read10),
        .data_in(r10),
        .data_out(ro10),
        .rw(in_rw[10])
      );


RAM_double_addr
  #( .AW(AW),
     .DW(DW))
  RAM11 (
        .clk(clk),
        .addr_write(addr_write11),
        .addr_read(addr_read11),
        .data_in(r11),
        .data_out(ro11),
        .rw(in_rw[11])
      );

endmodule



