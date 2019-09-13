//----------------------------------------------------------------------------
//-- Controlador del envío por UART de las imágenes procesadas, con cabecera.
//----------------------------------------------------------------------------
//-- September 2019. Written by Ivan Rios
//-- Base design by Juan Gonzalez (https://github.com/Obijuan/open-fpga-verilog-tutorial/wiki)
//-- GPL license
//----------------------------------------------------------------------------
`include "baudgen.vh"

//-- Modulo para envio de una cadena por el puerto serie
module control_uart (input wire clk,  //-- Reloj del sistema
                input wire rst,  //-- Señal de DTR
                input wire dtr,  //-- Señal de DTR
                input wire VSYNC,  //-- Señal de DTR
                input wire [7:0] data,  //-- Señal de data
                output wire ready,   //-- Salida de datos serie
                output wire tx   //-- Salida de datos serie
               );

//-- Velocidad a la que hacer las pruebas
parameter BAUD = `B12Mbauds;


//-- Dato a transmitir (normal y registrado)
reg [7:0] data_r;

//-- Señal para indicar al controlador el comienzo de la transmision
//-- de la cadena. Es la de DTR registrada
reg transmit;

//-- Microordenes
reg start;  //-- Transmitir cadena (cuando transmit = 1)

//-- Flag fin de transmisión
reg uart_flag_reg=0;     

//------------------------------------------------
//-- 	RUTA DE DATOS
//------------------------------------------------

//-- Instanciar la Unidad de transmision
uart_tx #(.BAUD(BAUD))
  uart_tx (
    .clk(clk),
    .rst(rst),
    .data(data_r),
    .start(start),
    .ready(ready),
    .tx(tx)
  );
 reg new_img=1;
 reg cena=0;
 reg VSYNC_ant=0;

//-- Registrar señal dtr para cumplir con normas diseño sincrono
always @(posedge clk) begin
  if(rst==1) begin
	transmit <= 0;
	new_img <= 0;
	VSYNC_ant<=0;
  end
  
  else begin
	VSYNC_ant<=VSYNC;
  
	  if(VSYNC && VSYNC_ant==0) begin
		transmit <= 1;
		new_img <= 1;
	  end
	  
	  else if(car_count==11 && new_img && cena) begin
		transmit <= 0;
		new_img <= 0;
	  end 
	  
	  else if(new_img) begin
		transmit <= 1;
	  end 
	  
	  else begin
		transmit <= dtr;
	  end
  end
  
end

//----------------------------------------------------
//-- CONTROLADOR
//----------------------------------------------------
localparam IDLE = 0;   //-- Reposo
localparam TXCAR = 2'd1;  //-- Transmitiendo caracter
localparam WAITING = 2'd2;   //-- Esperando hasta aceptación del caracter
localparam SENDING = 2'd3;   //-- ENVIANDO CARACTER
localparam END = 4;    //-- FIN DE TRANSMISION

//-- Registro de estado del automata
reg [2:0] state;

//-- Gestionar el cambio de estado
always @(posedge clk) begin

  if (rst == 1)
    //-- Ir al estado inicial
    state <= IDLE;

  else begin
    uart_flag_reg <= 0;
    cena <= 0;
  	
    case (state)
    
      IDLE: 
        if (transmit == 1) state <= TXCAR;
        else state <= IDLE;
        
        
      TXCAR: 
        if (ready == 1) state <= WAITING;
        else state <= TXCAR;
        
        
      WAITING: 
        if (ready == 0) state <= SENDING;
        else state <= WAITING;
        
        
      SENDING: 
        if (ready == 1) begin
        	state <= END;
          if (new_img) cena <= 1;	
      	  else
      		  uart_flag_reg <= 1;
		end
		
        else state <= SENDING;
        
        
      END: begin
        if (uart_flag_reg || cena) begin
        	state <= IDLE;
      		uart_flag_reg <= 0;
      		cena <= 0;
        end
        
        else state <= END;
	   end
	  
      //-- Necesario para evitar latches
      default:
         state <= IDLE;
        

    endcase
  end
end
//-- Generacion de las microordenes
always @(posedge clk) begin
  
  case (state)
    IDLE: begin
      start <= 0;
    end

    TXCAR: begin
      start <= 1;
    end

    WAITING: begin
      start <= 0;	
    end

    SENDING: begin
      start <= 0;	
    end

    END: begin
      start <= 0;
    end

    default: begin
      start <= 0;
    end
  endcase
end

//-- Multiplexor con los caracteres de la cadena a transmitir
//-- se seleccionan mediante la señal car_count
always @(posedge clk) begin
 if(new_img) begin
  case (car_count)
    0: data_r <= "\n";
    1: data_r <= "\n";
    2: data_r <= "N";
    3: data_r <= "e";
    4: data_r <= "w";
    5: data_r <= " ";
    6: data_r <= "I";
    7: data_r <= "m";
    8: data_r <= "g";
    9: data_r <= "\r";
    10: data_r <= "\n";
    11: data_r <= "\n";
    default: data_r <= ".";
  endcase
 end
  else
    data_r <= data;
  
end  
//-- Contador de caracteres
//-- Cuando la microorden cena esta activada, se incrementa
reg [4:0] car_count;

always @(posedge clk) begin
  if (rst == 1)
    car_count = 0;
  else if (car_count<11 && new_img && cena)
    car_count = car_count + 1;
  else if (car_count==11 && !new_img) begin
    car_count = 0;
  end
end

endmodule




