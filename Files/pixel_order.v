//----------------------------------------------------------------------------
//-- Colocación de RAMs para la correcta aplicación del filtro Sobel
//----------------------------------------------------------------------------
//-- September 2019. Written by Ivan Rios
//-- GPL license
//----------------------------------------------------------------------------
//-- Cada valor de "order" indica una colocación distinta de las RAMs dentro
//-- de la máscara que se tiene que aplicar en ese instante.
//-- p0,p1 y p2 son los valores superiores de la máscara.
//-- p3 y p5 son los valores del centro izquierda y derecha respectivamente
//-- (el centro no se opera.
//-- p6,p7 y p8 son los valores inferiores de la máscara.
//----------------------------------------------------------------------------
module pixel_order( 


	input wire clk,rst,
	
	input wire [3:0] order,
	
	input wire [7:0] ro0,ro1,ro2,
					 ro3,ro4,ro5,
					 ro6,ro7,ro8,
					 ro9,ro10,ro11,
					 
	output wire [7:0]p0,p1,p2,
					 p3,   p5,
					 p6,p7,p8
					 
	);
   

reg [7:0] ou0=0,ou1=0,ou2=0,
		  ou3=0,	  ou5=0,
		  ou6=0,ou7=0,ou8=0;
		  
		  
assign p0  = ou0 ;
assign p1  = ou1 ;
assign p2  = ou2 ;
assign p3  = ou3 ;
assign p5  = ou5 ;
assign p6  = ou6 ;
assign p7  = ou7 ;
assign p8  = ou8 ;

    
always @(posedge clk) begin

 if(rst) begin
	ou0<= ro0;
    ou1<= ro1;
    ou2<= ro2;
    ou3<= ro3;
    ou5<= ro5;
    ou6<= ro6;
    ou7<= ro7;
    ou8<= ro8;
 end
	
				
 else begin
  case (order)

    0: begin
    	ou0<= ro0;
    	ou1<= ro1;
    	ou2<= ro2;
    	ou3<= ro3;
    	ou5<= ro5;
    	ou6<= ro6;
    	ou7<= ro7;
    	ou8<= ro8;
    
    end


    1: begin
    	ou0<= ro1;
    	ou1<= ro2;
    	ou2<= ro0;
    	ou3<= ro4;
    	ou5<= ro3;
    	ou6<= ro7;
    	ou7<= ro8;
    	ou8<= ro6;
    
    end


    2: begin
    	ou0<= ro2;
    	ou1<= ro0;
    	ou2<= ro1;
    	ou3<= ro5;
    	ou5<= ro4;
    	ou6<= ro8;
    	ou7<= ro6;
    	ou8<= ro7;
    
    end


    3: begin
    	ou0<= ro3;
    	ou1<= ro4;
    	ou2<= ro5;
    	ou3<= ro6;
    	ou5<= ro8;
    	ou6<= ro9;
    	ou7<= ro10;
    	ou8<= ro11;
    
    end


    4: begin
    	ou0<= ro4;
    	ou1<= ro5;
    	ou2<= ro3;
    	ou3<= ro7;
    	ou5<= ro6;
    	ou6<= ro10;
    	ou7<= ro11;
    	ou8<= ro9;
    
    end


    5: begin
    	ou0<= ro5;
    	ou1<= ro3;
    	ou2<= ro4;
    	ou3<= ro8;
    	ou5<= ro7;
    	ou6<= ro11;
    	ou7<= ro9;
    	ou8<= ro10;
    
    end


    6: begin
    	ou0<= ro6;
    	ou1<= ro7;
    	ou2<= ro8;
    	ou3<= ro9;
    	ou5<= ro11;
    	ou6<= ro0;
    	ou7<= ro1;
    	ou8<= ro2;
    
    end


    7: begin
    	ou0<= ro7;
    	ou1<= ro8;
    	ou2<= ro6;
    	ou3<= ro10;
    	ou5<= ro9;
    	ou6<= ro1;
    	ou7<= ro2;
    	ou8<= ro0;
    
    end


    8: begin
    	ou0<= ro8;
    	ou1<= ro6;
    	ou2<= ro7;
    	ou3<= ro11;
    	ou5<= ro10;
    	ou6<= ro2;
    	ou7<= ro0;
    	ou8<= ro1;
    
    end


    9: begin
    	ou0<= ro9;
    	ou1<= ro10;
    	ou2<= ro11;
    	ou3<= ro0;
    	ou5<= ro2;
    	ou6<= ro3;
    	ou7<= ro4;
    	ou8<= ro5;
    
    end


    10: begin
    	ou0<= ro10;
    	ou1<= ro11;
    	ou2<= ro9;
    	ou3<= ro1;
    	ou5<= ro0;
    	ou6<= ro4;
    	ou7<= ro5;
    	ou8<= ro3;
    
    end


    11: begin
    	ou0<= ro11;
    	ou1<= ro9;
    	ou2<= ro10;
    	ou3<= ro2;
    	ou5<= ro1;
    	ou6<= ro5;
    	ou7<= ro3;
    	ou8<= ro4;
    
    end

  endcase
 end

end


endmodule
