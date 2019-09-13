//----------------------------------------------------------------------------
//-- Control del orden de la máscara para el filtro Sobel
//----------------------------------------------------------------------------
//-- September 2019. Written by Ivan Rios
//-- GPL license
//----------------------------------------------------------------------------
module mask_control #(             //-- Parametros
         parameter WIDTH_SOBEL = 8)
( 

	input wire clk,rst,
	input wire mask_flag,	
	input wire VSYNC,		
	input wire Href,			 
	output reg [3:0] order,
	output wire sobel_pulse					 
	);

reg VSYNC_ant=0;
reg Href_ant=0;
reg first_mask=1;
    
reg[1:0] pos_mask_h=0;
reg[1:0] pos_mask_v=0;
reg reg_sobel_pulse=0;
 
reg [8:0] count_width_row=0;

assign sobel_pulse = reg_sobel_pulse;
    
always @(posedge clk) begin

 VSYNC_ant <= VSYNC;
 Href_ant <= Href;

  if (rst) begin
    order <= 0;
    pos_mask_h <= 0;
	first_mask<=1;
	reg_sobel_pulse<=0;
	count_width_row<=0;
  end

  else if (VSYNC && !VSYNC_ant) begin //Nueva imagen
	first_mask<=1;
	pos_mask_v<=0;
  end

  else if (Href && !Href_ant) begin //Desplazamiento vertical de la máscara
	pos_mask_h<=0;
	first_mask<=1;
	pos_mask_v<=pos_mask_v+1;
	count_width_row<=0;
  end
  
  else
	reg_sobel_pulse<=0;
	
	if (mask_flag) 
   	  if (count_width_row<WIDTH_SOBEL) begin
	  count_width_row<=count_width_row+1;
	
		reg_sobel_pulse<=1;	
	
		if (first_mask) begin //primer elemento
			pos_mask_h<=0;
			first_mask<=0;
		end
		
		else if (pos_mask_h==2) begin //Ha pasado las 3 RAMs
			pos_mask_h<=0;
		end
		
		else begin //Desplazamiento horizontal de la máscara
			pos_mask_h<=pos_mask_h+1;
		end	
		
  end
end

//----------------------------- Posición máscarasc
always @(posedge clk) begin
  if(!rst)

	if (pos_mask_v==0) begin
		if (pos_mask_h==0)
			order<=0;
		else if (pos_mask_h==1)
			order<=1;
		else if (pos_mask_h==2)
			order<=2;
			
	end
			
	else if (pos_mask_v==1) begin
		if (pos_mask_h==0)
			order<=3;
		else if (pos_mask_h==1)
			order<=4;
		else if (pos_mask_h==2)
			order<=5;
			
	end
			
	else if (pos_mask_v==2) begin
		if (pos_mask_h==0)
			order<=6;
		else if (pos_mask_h==1)
			order<=7;
		else if (pos_mask_h==2)
			order<=8;
			
	end
			
	else if (pos_mask_v==3) begin
		if (pos_mask_h==0)
			order<=9;
		else if (pos_mask_h==1)
			order<=10;
		else if (pos_mask_h==2)
			order<=11;
			
	end
	
	
end




endmodule
