//----------------------------------------------------------------------------
//-- Memoria RAM con doble acceso a memoria
//------------------------------------------
//-- September 2019. Written by Ivan Rios
//-- Base design by Juan Gonzalez (https://github.com/Obijuan/open-fpga-verilog-tutorial/wiki)
//-- GPL license
//----------------------------------------------------------------------------
//-- Memoria con los siguientes parametros:
//--  * AW: Numero de bits de las direcciones
//--  * DW: Numero de bits de los datos
//--  * ROMFILE: Fichero a usar para cargar la memoria
//-- Con este componente podemos hacer memorias ram de cualquier tamaño
//----------------------------------------------------------------------------

module RAM_double_addr #(             //-- Parametros
         parameter AW = 5,   //-- Bits de las direcciones (Adress width)
         parameter DW = 4)   //-- Bits de los datos (Data witdh)

       (        //-- Puertos
         input clk,                      //-- Señal de reloj global
         input wire [AW-1: 0] addr_write,      //-- Direcciones de escritura
         input wire [AW-1: 0] addr_read,      //-- Direcciones de lectura
         input wire rw,                  //-- Modo lectura (1) o escritura (0)
         input wire [DW-1: 0] data_in,   //-- Dato de entrada
         output reg [DW-1: 0] data_out); //-- Dato a escribir

//-- Parametro: Nombre del fichero con el contenido de la RAM
parameter ROMFILE = "bufferini.list";

//-- Calcular el numero de posiciones totales de memoria
localparam NPOS = 2 ** AW;

  //-- Memoria
  reg [DW-1: 0] ram [0: NPOS-1];

  //-- Lectura de la memoria
  always @(posedge clk) begin
    if (rw == 1) begin
    	 data_out <= ram[addr_read];
   	end
   	
    else if (rw == 0) begin
    	 ram[addr_write] <= data_in;
    	 data_out <= ram[addr_write];
    end
  end

//-- Cargar en la memoria el fichero ROMFILE
//-- Los valores deben estan dados en hexadecimal
initial begin
  $readmemh(ROMFILE, ram);
end


endmodule



