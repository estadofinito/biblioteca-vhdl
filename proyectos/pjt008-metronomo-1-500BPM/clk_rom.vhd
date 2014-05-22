----------------------------------------------------------------------------------
-- Compaa:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creacin:   2014/04/24 17:41:30
-- Nombre del mdulo:   clk_rom - Behavioral 
-- Comentarios adicionales: 
--   Este divisor de frecuencia toma sus valores de una memoria ROM que contiene
--   los valores de los contadores. Por lo tanto, el rango de frecuencias depende
--   de la ROM.
--
-- Comentarios adicionales:
--   Se puede encontrar ms informacin en la siguiente direccin:
--   http://www.estadofinito.com/metronomo-en-vhdl-2/
--
-- Revisin:
--   Revisin 0.02 - El tiempo en alto es constante, y corresponde a un periodo de
--                   10Hz (el sonido del metrnomo debe tener la misma duracin 
--                   para todas las diversas frecuencias).
--                     Dicha frecuencia debe ser mayor a la frecuencia mayor del 
--                   sistema, F > 512 BPM (u 8.53 Hz).
--                     En este caso, la frecuencia o tiempo en alto es de 10Hz.
--   Revisin 0.01 - Archivo creado.
----------------------------------------------------------------------------------
 
library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
 
entity clk_rom is
	GENERIC (
		NBITS   : integer := 28 -- Cantidad de bits que tiene cada registro en la ROM.
	);
    PORT (
        clk     : in  STD_LOGIC; -- Reloj de entrada de 3.125MHz.
        reset   : in  STD_LOGIC;
		escala  : in  STD_LOGIC_VECTOR(NBITS-1 downto 0);
        clk_out : out STD_LOGIC  -- Reloj de salida, dependiente del valor en memoria.
    );
end clk_rom;
 
architecture Behavioral of clk_rom is
	-- Seal utilizada para procesamiento interno de la seal de salida.
    signal temporal    : STD_LOGIC;
	-- Seal que cubre el rango que puede alcanzar la ROM.
	signal contador    : integer range 0 to (2**(NBITS-4))-1 := 0;
	-- Transformacin de la escala de entrada a tipo numrico para el uso de operadores aritmticos.
	signal escala_num  : UNSIGNED(NBITS-1 downto 0) := (others => '0');
begin
	-- Actualizacin de los datos de escala.
	escala_num   <= UNSIGNED(escala);           -- Conversin de vector a nmero.

	-- Procesamiento para el divisor de frecuencia.
    divisor_frecuencia: process (clk, reset) begin
        if (reset = '1') then
			temporal <= '0';
			contador <= 0;
		elsif rising_edge(clk) then
			if (contador = escala_num) then
				contador <= 0;
			else
				if (contador < 312500) then
					-- Tiempo de 10Hz en alto.
					temporal <= '1';
				else
					-- Todo lo dems en bajo.
					temporal <= '0';
				end if;
				contador <= contador + 1;
			end if;
		end if;
    end process;
 
	-- Asignacin de la seal de salida.
    clk_out <= temporal;
end Behavioral;