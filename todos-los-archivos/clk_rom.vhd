----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2014/04/24 17:41:30
-- Nombre del módulo:   clk_rom - Behavioral 
-- Comentarios adicionales: 
--   Este divisor de frecuencia toma sus valores de una memoria ROM que contiene
--   los valores de los contadores. Por lo tanto, el rango de frecuencias depende
--   de la ROM.
--
-- Comentarios adicionales:
--   Se puede encontrar más información en la siguiente dirección:
--   http://www.estadofinito.com/metronomo-en-vhdl-2/
--
-- Revisión:
--   Revisión 0.02 - El tiempo en alto es constante, y corresponde a un periodo de
--                   10Hz (el sonido del metrónomo debe tener la misma duración 
--                   para todas las diversas frecuencias).
--                     Dicha frecuencia debe ser mayor a la frecuencia mayor del 
--                   sistema, F > 512 BPM (u 8.53 Hz).
--                     En este caso, la frecuencia o tiempo en alto es de 10Hz.
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------
 
library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
 
entity clk_rom is
	GENERIC (
		NBITS   : integer := 28  -- Cantidad de bits que tiene cada registro en la ROM.
	);
    PORT (
        clk     : in  STD_LOGIC; -- Reloj de entrada de 3.125MHz.
        reset   : in  STD_LOGIC;
		escala  : in  STD_LOGIC_VECTOR(NBITS-1 downto 0);
        clk_out : out STD_LOGIC  -- Reloj de salida, dependiente del valor en memoria.
    );
end clk_rom;
 
architecture Behavioral of clk_rom is
	-- Señal utilizada para procesamiento interno de la señal de salida.
    signal temporal    : STD_LOGIC;
	-- Señal que cubre el rango que puede alcanzar la ROM.
	signal contador    : integer range 0 to (2**(NBITS-4))-1 := 0;
	-- Transformación de la escala de entrada a tipo numérico para el uso de operadores aritméticos.
	signal escala_num  : UNSIGNED(NBITS-1 downto 0) := (others => '0');
begin
	-- Actualización de los datos de escala.
	escala_num   <= UNSIGNED(escala); -- Conversión de vector a número.

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
					-- Todo lo demás en bajo.
					temporal <= '0';
				end if;
				contador <= contador + 1;
			end if;
		end if;
    end process;
 
	-- Asignación de la señal de salida.
    clk_out <= temporal;
end Behavioral;