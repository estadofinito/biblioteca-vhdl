----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2014/04/24 23:21:40
-- Nombre del módulo:   bin2bcd9 - Behavioral 
-- Comentarios adicionales: 
--   Este componente se encarga de transformar un número binario de nueve bits
--   a tres dígitos en código BCD.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bin2bcd9 is
	GENERIC(
		NBITS  : integer :=  9; -- Cantidad de bits del número binario.
		NSALIDA: integer := 11  -- Cantidad de bits de salida en formato BCD.
	);
	PORT(
		num_bin: in  STD_LOGIC_VECTOR(NBITS-1   downto 0);
		num_bcd: out STD_LOGIC_VECTOR(NSALIDA-1 downto 0)
	);
end bin2bcd9;

architecture Behavioral of bin2bcd9 is
begin
	proceso_bcd: process(num_bin)
		variable z: STD_LOGIC_VECTOR(NBITS+NSALIDA-1 downto 0);
	begin
		-- Inicialización de datos en cero.
		z := (others => '0');
		-- Se realizan los primeros tres corrimientos.
		z(NBITS+2 downto 3) := num_bin;
		-- Ciclo para las iteraciones restantes.
		for i in 0 to NBITS-4 loop
			-- Unidades (4 bits).
			if z(NBITS+3 downto NBITS) > 4 then
				z(NBITS+3 downto NBITS) := z(NBITS+3 downto NBITS) + 3;
			end if;
			-- Decenas (4 bits).
			if z(NBITS+7 downto NBITS+4) > 4 then
				z(NBITS+7 downto NBITS+4) := z(NBITS+7 downto NBITS+4) + 3;
			end if;
			-- Centenas (3 bits).
			if z(NBITS+10 downto NBITS+8) > 4 then
				z(NBITS+10 downto NBITS+8) := z(NBITS+10 downto NBITS+8) + 3;
			end if;
			-- Corrimiento a la izquierda.
			z(NBITS+NSALIDA-1 downto 1) := z(NBITS+NSALIDA-2 downto 0);
		end loop;
		-- Pasando datos de variable Z, correspondiente a BCD.
		num_bcd <= z(NBITS+NSALIDA-1 downto NBITS);
	end process;
end Behavioral;