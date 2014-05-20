----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2012/10/26 21:01:42
-- Nombre del módulo:   reloj - Behavioral
-- Descripción: 
--   Une el contador del reloj con los divisores de frecuencia y el controlador 
--   de siete segmentos completo para mostrar la hora en una tarjeta Basys2.
-- Comentarios adicionales:
--   Se puede encontrar más información en la siguiente dirección:
--   http://www.estadofinito.com/reloj-digital/
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reloj is
	PORT(
		clk   : IN  STD_LOGIC;
		reset : IN  STD_LOGIC;
		salida: OUT STD_LOGIC_VECTOR(7 downto 0);
		MUX   : OUT STD_LOGIC_VECTOR(3 downto 0)
	);
end reloj;

architecture Behavioral of reloj is
	COMPONENT clk1Hz IS
		PORT (
            entrada: IN  STD_LOGIC;
            reset  : IN  STD_LOGIC;
            salida : OUT STD_LOGIC
        );
    END COMPONENT;
	
	COMPONENT contador_reloj IS
		PORT (
			clk  : IN  STD_LOGIC;
			reset: IN  STD_LOGIC;
			H1   : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			H0   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			M1   : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			M0   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT siete_segmentos_completo IS
		PORT (
			clk   : IN  STD_LOGIC;
			reset : IN  STD_LOGIC;
			D0    : IN  STD_LOGIC_VECTOR(5 downto 0);
			D1    : IN  STD_LOGIC_VECTOR(5 downto 0);
			D2    : IN  STD_LOGIC_VECTOR(5 downto 0);
			D3    : IN  STD_LOGIC_VECTOR(5 downto 0);
			salida: OUT STD_LOGIC_VECTOR(7 downto 0);
			MUX   : OUT STD_LOGIC_VECTOR(3 downto 0)
		);
	END COMPONENT;
	
	signal clk_out : STD_LOGIC := '0';
	signal HH1, MM1: STD_LOGIC_VECTOR(2 downto 0);
	signal HH0, MM0: STD_LOGIC_VECTOR(3 downto 0);
	signal pHH1, pHH0, pMM1, pMM0: STD_LOGIC_VECTOR(5 downto 0);
begin
	--PORT MAPs necesarios para habilitar el reloj.
	clk_i: clk1Hz PORT MAP(clk, reset, clk_out);
	cnt_i: contador_reloj PORT MAP(clk_out, reset, HH1, HH0, MM1, MM0);
	seg_i: siete_segmentos_completo PORT MAP(clk, reset, pMM0, pMM1, pHH0, pHH1, salida, MUX);
	
	--Padding de las señales del contador para siete segmentos.
	pHH1 <= "000" & HH1;
	pHH0 <= "00"  & HH0;
	pMM1 <= "000" & MM1;
	pMM0 <= "00"  & MM0;
end Behavioral;