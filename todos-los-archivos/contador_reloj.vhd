----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2012/10/26 12:26:23
-- Nombre del módulo:   contador_reloj - Behavioral
-- Descripción: 
--   Contador para el reloj. Se encarga de recibir una señal de 1/60Hz (1 minuto)
--   y contar el tiempo para mostrar la hora y los minutos.
--   A la salida, entrega los cuatro dígitos correspondientes a HH:mm.
--
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_reloj is
	PORT (
		clk  : IN  STD_LOGIC; --Reloj de 1Hz.
		reset: IN  STD_LOGIC; --Señal de reset.
		H1   : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); --Segundo digito de la hora.
		H0   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --Primer digito de la hora.
		M1   : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); --Segundo digito de los minutos.
		M0   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)  --Primer digito de los minutos.
	);
end contador_reloj;

architecture Behavioral of contador_reloj is
	signal mm1: UNSIGNED(2 downto 0) := "000" ;
	signal mm0: UNSIGNED(3 downto 0) := "0000";
	signal hh1: UNSIGNED(2 downto 0) := "000" ;
	signal hh0: UNSIGNED(3 downto 0) := "0000";
begin
	reloj: process (clk, reset) begin
		if reset = '1' then
			hh1 <= "000" ;
			hh0 <= "0000";
			mm1 <= "000" ;
			mm0 <= "0000";
		elsif rising_edge(clk) then
			mm0 <= mm0 + 1;
			if mm0 = 9 then
				mm1 <= mm1 + 1;
				mm0 <= "0000";
			end if;
			-- Al pasar 59 minutos, contar una hora.
			if mm1 = 5 AND mm0 = 9 then
				hh0 <= hh0 + 1;
				mm1 <= "000";
			end if;
			if hh0 = 9 then
				hh1 <= hh1 + 1;
				hh0 <= "0000";
			end if;
			-- Al pasar 23:59, regresar a 00:00.
			if hh1 = 2 AND hh0 = 3 AND mm1 = 5 AND mm0 = 9 then
				hh1 <= "000";
				hh0 <= "0000";
			end if;
		end if;
	end process;
	
	--Asignación de señales.
	H1 <= STD_LOGIC_VECTOR(hh1);
	H0 <= STD_LOGIC_VECTOR(hh0);
	M1 <= STD_LOGIC_VECTOR(mm1);
	M0 <= STD_LOGIC_VECTOR(mm0);
end Behavioral;