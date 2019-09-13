//----------------------------------------------------------------------------
//-- Control de escritura y lectura de las 12 RAMs 
//----------------------------------------------------------------------------
//-- September 2019. Written by Ivan Rios
//-- GPL license
//----------------------------------------------------------------------------
`default_nettype none

module control_RAM
         (
	input wire clk,rst,
	
	input wire [7:0] in_pixel,
	
	input wire PCLK,
	input wire Href,
	input wire VSYNC,
					 
	output wire [7:0] r0,r1,r2,
					  r3,r4,r5,
					  r6,r7,r8,
					  r9,r10,r11,
					  
	output wire[6:0] addr_write0,addr_write1,addr_write2,
					addr_write3,addr_write4,addr_write5,
					addr_write6,addr_write7,addr_write8,
					addr_write9,addr_write10,addr_write11,
					  
	output wire[6:0] addr_read0,addr_read1,addr_read2,
					addr_read3,addr_read4,addr_read5,
					addr_read6,addr_read7,addr_read8,
					addr_read9,addr_read10,addr_read11,  
	
	output wire [11:0] out_rw,
	output wire RAM_flag
					 
	);



reg [7:0] ru0=0 ,ru1=0 ,ru2=0 ,
		  ru3=0 ,ru4=0 ,ru5=0,
		  ru6=0 ,ru7=0 ,ru8=0 ,
		  ru9=0 ,ru10=0 ,ru11=0;
					  
reg[6:0] addru_write0=0 ,addru_write1=0 ,addru_write2=0 ,
		 addru_write3=0 ,addru_write4=0 ,addru_write5=0,
		 addru_write6=0 ,addru_write7=0 ,addru_write8=0 ,
		 addru_write9=0 ,addru_write10=0 ,addru_write11=0;
					  
reg[6:0] addru_read0=0 ,addru_read1=0 ,addru_read2=0 ,
		 addru_read3=0 ,addru_read4=0 ,addru_read5=0, 
		 addru_read6=0 ,addru_read7=0 ,addru_read8=0 ,
		 addru_read9=0 ,addru_read10=0 ,addru_read11=0; 

reg [11:0] addr=0; 
reg [11:0] addr_sobel=0; 

assign r0[7:0] = ru0[7:0];
assign r1[7:0] = ru1[7:0];
assign r2[7:0] = ru2[7:0];
assign r3[7:0] = ru3[7:0];
assign r4[7:0] = ru4[7:0];
assign r5[7:0] = ru5[7:0];
assign r6[7:0] = ru6[7:0];
assign r7[7:0] = ru7[7:0];
assign r8[7:0] = ru8[7:0];
assign r9[7:0] = ru9[7:0];
assign r10[7:0] = ru10[7:0];
assign r11[7:0] = ru11[7:0];

assign addr_write0 = addru_write0;
assign addr_write1 = addru_write1;
assign addr_write2 = addru_write2;
assign addr_write3 = addru_write3;
assign addr_write4 = addru_write4;
assign addr_write5 = addru_write5;
assign addr_write6 = addru_write6;
assign addr_write7 = addru_write7;
assign addr_write8 = addru_write8;
assign addr_write9 = addru_write9;
assign addr_write10 = addru_write10;
assign addr_write11 = addru_write11;

assign addr_read0 = addru_read0;
assign addr_read1 = addru_read1;
assign addr_read2 = addru_read2;
assign addr_read3 = addru_read3;
assign addr_read4 = addru_read4;
assign addr_read5 = addru_read5;
assign addr_read6 = addru_read6;
assign addr_read7 = addru_read7;
assign addr_read8 = addru_read8;
assign addr_read9 = addru_read9;
assign addr_read10 = addru_read10;
assign addr_read11 = addru_read11;

reg [11:0] outu_rw=0;
reg RAM_flag_reg=0;
	  
assign out_rw = outu_rw;
	  
assign RAM_flag = RAM_flag_reg;

reg PCLK_ant=0;
reg PCLK_ant2=0;
reg getting_img=0;
reg VSYNC_ant=0;
reg Href_ant=0;
		 
reg [1:0] state=0;
reg [1:0] state_sobel=0;

reg [2:0] fila=0;


localparam FIRST_STATE = 0;
localparam LEFT_STATE  = 1;
localparam CENTER_STATE= 2;
localparam RIGHT_STATE = 3;

// Proceso de selección qué memorias son de lectura o escritura
always @(posedge clk) begin

VSYNC_ant <= VSYNC;

  if(rst || VSYNC) begin
	outu_rw<=6'b010_101;
	fila<=4;
	getting_img<=0;
  end

  else begin
	Href_ant <= Href;
  
	if(VSYNC_ant && !VSYNC) begin
		outu_rw<=12'b000_000_000_000;
		getting_img<=1;	
	end
			
	if (!Href_ant && Href && getting_img) begin
	
		if(fila==4) begin
		outu_rw<=12'b000_000_000_000;
			fila<=1;
		end
		else if(fila==0) begin
			outu_rw<=12'b111_111_111_000;
			fila<=1;
		end  
		else if(fila==1) begin
			outu_rw<=12'b111_111_000_111;
			fila<=2;
		end
		else if(fila==2) begin
			outu_rw<=12'b111_000_111_111;
			fila<=3;
		end
		else if(fila==3) begin
			outu_rw<=12'b000_111_111_111;
			fila<=0;
		end
	end
  end
end //always    

//--------------------------------------- Secuencia Almacenar en RAM 
always @(posedge clk) begin

 if(rst ||!Href) begin
    RAM_flag_reg<=0;
	addr<=0;
	state<=0;
 end

 else begin
  PCLK_ant<=PCLK;
  RAM_flag_reg<=0;
 
 
  if (!PCLK_ant2 && PCLK && Href && getting_img) begin
 	RAM_flag_reg<=1;
	case (fila) 
	
		1: begin
		
		  case (state)
		  	0: begin
				ru0<= in_pixel;
				addru_write0<=addr;
				state<=1;
			end
			
		  	1: begin
				ru1<=in_pixel;
				addru_write1<=addr;
				state<=2;
			end
			
		  	2 : begin
				ru2<=in_pixel;
				addru_write2<=addr;
				addr<=addr+1;
				state<=0;
		  	end 
			
		  endcase
		end
		
		2: begin
		  case (state)
		  	0: begin
				ru3<= in_pixel;
				addru_write3<=addr;
				state<=1;
			end
			
		  	1: begin
				ru4<=in_pixel;
				addru_write4<=addr;
				state<=2;
			end
			
		  	2 : begin
				ru5<=in_pixel;
				addru_write5<=addr;
				addr<=addr+1;
				state<=0;
			end
		  endcase
		end 
		
		3: begin
		  case (state)
		  	0: begin
				ru6<= in_pixel;
				addru_write6<=addr;
				state<=1;
			end
			
		  	1: begin
				ru7<=in_pixel;
				addru_write7<=addr;
				state<=2;
			end
			
		  	2 : begin
				ru8<=in_pixel;
				addru_write8<=addr;
				addr<=addr+1;
				state<=0;
			end
		  endcase
		end 
		
		0: begin
		  case (state)
		  	0: begin
				ru9<= in_pixel;
				addru_write9<=addr;
				state<=1;
			end
			
		  	1: begin
				ru10<=in_pixel;
				addru_write10<=addr;
				state<=2;
			end
			
		  	2 : begin
				ru11<=in_pixel;
				addru_write11<=addr;
				addr<=addr+1;
				state<=0;
			end
		  endcase
		end 
	endcase
  	
  end //if (PCLK!=PCLK_ant && PCLK && Href)
  
 end // else begin
 
end // Always

//--------------------------------------- Secuencia Lectura de RAMs
always @(posedge clk) begin

 if(rst ||!Href) begin
	state_sobel<=0;
	addr_sobel<=0;
 end

 else begin
	PCLK_ant2<=PCLK;
 
  if (!PCLK_ant2 && PCLK && Href && getting_img) begin
	case (fila) 
	
      1: begin
		case (state_sobel)
				
		  FIRST_STATE: begin
    		state_sobel<=CENTER_STATE;
    		addr_sobel<=1;
    		addru_read3<=0;addru_read4<=0;addru_read5<=0;
    		addru_read6<=0;addru_read7<=0;addru_read8<=0;
    		addru_read9<=0;addru_read10<=0;addru_read11<=0;
    	  end
				
		  LEFT_STATE: begin
    		addr_sobel<=addr_sobel+1;
    		addru_read5<=addr_sobel;
    		addru_read8<=addr_sobel;
    		addru_read11<=addr_sobel;
    		state_sobel<=CENTER_STATE;
    	  end
				
		  CENTER_STATE: begin
    		state_sobel<=RIGHT_STATE;
    		addru_read3<=addr_sobel;
    		addru_read6<=addr_sobel;
    		addru_read9<=addr_sobel;
    	  end
				
		  RIGHT_STATE: begin
    		addru_read4<=addr_sobel;
    		addru_read7<=addr_sobel;
    		addru_read10<=addr_sobel;
    		state_sobel<=LEFT_STATE;
    	  end
			  
		endcase //state_sobel_0
      end // case 0
	
      2: begin
		case (state_sobel)
				
		  FIRST_STATE: begin
    		state_sobel<=CENTER_STATE;
    		addru_read0<=0;addru_read1<=0;addru_read2<=0;
    		addru_read6<=0;addru_read7<=0;addru_read8<=0;
    		addru_read9<=0;addru_read10<=0;addru_read11<=0;
    		addr_sobel<=1;
    	  end
				
		  LEFT_STATE: begin
    		addr_sobel<=addr_sobel+1;
    		state_sobel<=CENTER_STATE;
    		addru_read2<=addr_sobel;
    		addru_read8<=addr_sobel;
    		addru_read11<=addr_sobel;
    	  end
				
		  CENTER_STATE: begin
    		state_sobel<=RIGHT_STATE;
    		addru_read0<=addr_sobel;
    		addru_read6<=addr_sobel;
    		addru_read9<=addr_sobel;
    	  end
				
		  RIGHT_STATE: begin
    		state_sobel<=LEFT_STATE;
    		addru_read1<=addr_sobel;
    		addru_read7<=addr_sobel;
    		addru_read10<=addr_sobel;
    	  end
			  
		endcase //state_sobel_1
 	  end //case 1
	
      3: begin
		case (state_sobel)
				
		  FIRST_STATE: begin
    		state_sobel<=CENTER_STATE;
    		addru_read0<=0;addru_read1<=0;addru_read2<=0;
    		addru_read3<=0;addru_read4<=0;addru_read5<=0;
    		addru_read9<=0;addru_read10<=0;addru_read11<=0;
    		addr_sobel<=1;
    	  end
				
		  LEFT_STATE: begin
    		addr_sobel<=addr_sobel+1;
    		state_sobel<=CENTER_STATE;
    		addru_read2<=addr_sobel;
    		addru_read5<=addr_sobel;
    		addru_read11<=addr_sobel;
    	  end
				
		  CENTER_STATE: begin
    		state_sobel<=RIGHT_STATE;
    		addru_read0<=addr_sobel;
    		addru_read3<=addr_sobel;
    		addru_read9<=addr_sobel;
    	  end
				
		  RIGHT_STATE: begin
    		state_sobel<=LEFT_STATE;
    		addru_read1<=addr_sobel;
    		addru_read4<=addr_sobel;
    		addru_read10<=addr_sobel;
    	  end
			  
		endcase //state_sobel_2
 	  end //case 2
	
      0: begin
		case (state_sobel)
				
		  FIRST_STATE: begin
    		state_sobel<=CENTER_STATE;
    		addru_read0<=0;addru_read1<=0;addru_read2<=0;
    		addru_read3<=0;addru_read4<=0;addru_read5<=0;
    		addru_read6<=0;addru_read7<=0;addru_read8<=0;
    		addr_sobel<=1;
    	  end
				
		  LEFT_STATE: begin
    		addr_sobel<=addr_sobel+1;
    		addru_read2<=addr_sobel;
    		addru_read5<=addr_sobel;
    		addru_read8<=addr_sobel;
    		state_sobel<=CENTER_STATE;
    	  end
				
		  CENTER_STATE: begin
    		state_sobel<=RIGHT_STATE;
    		addru_read0<=addr_sobel;
    		addru_read3<=addr_sobel;
    		addru_read6<=addr_sobel;
    	  end
				
		  RIGHT_STATE: begin
    		state_sobel<=LEFT_STATE;
    		addru_read1<=addr_sobel;
    		addru_read4<=addr_sobel;
    		addru_read7<=addr_sobel;
    	  end
			  
		endcase //state_sobel_2
 	  end // case 3
	endcase
  	
  end //if (PCLK!=PCLK_ant && PCLK && Href)
  
 end // else begin
 
end // Always

endmodule
