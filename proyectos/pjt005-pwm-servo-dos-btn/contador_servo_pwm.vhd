----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2013/06/01 19:23:01
-- Nombre del módulo:   contador_servo_pwm - Behavioral
-- Descripción: 
--   Contador de 0 a 127, cuyo valor incrementa o decrementa gracias a un botón
--   para cada función (un botón incrementa, un botón decrementa).
--
-- Comentarios adicionales:
--   Se puede encontrar más información en la siguiente dirección:
--   http://www.estadofinito.com/control-servomotor-dos-botones/
--
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador_servo_pwm is
    PORT (
        clk   : IN  STD_LOGIC; -- Reloj de 64kHz.
        reset : IN  STD_LOGIC; -- Botón de reset.
		cnt_up: IN  STD_LOGIC; -- Botón de incremento.
		cnt_dn: IN  STD_LOGIC; -- Botón de decremento.
        pos   : OUT STD_LOGIC_VECTOR(6 downto 0) -- Salida a servomotor.
    );
end contador_servo_pwm;

architecture Behavioral of contador_servo_pwm is
	-- Señal utilizada para modificar la salida "pos".
	signal contador: UNSIGNED(6 downto 0) := (OTHERS => '0');
begin
	proceso_contador: process (clk, reset, cnt_up, cnt_dn) begin
		if (reset = '1') then
			contador <= (others => '0');
		elsif rising_edge(clk) then
			if (cnt_up = '1' AND contador < 127) then
				contador <= contador + 1;
			elsif (cnt_dn = '1' AND contador > 0) then
				contador <= contador - 1;
			end if;
		end if;
	end process;
	
	-- Asignación del valor del contador a la salida del módulo.
	pos <= STD_LOGIC_VECTOR(contador);
end Behavioral;