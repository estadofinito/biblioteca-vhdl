----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2014/05/08 22:15:22
-- Nombre del módulo:   clk_rom_1_512BPM - Behavioral 
-- Comentarios adicionales: 
--   Este componente une la ROM de 512 localidades de 28 bits, con el divisor de
--   frecuencia que toma valor de la ROM, con un reloj de 3.125MHz para lograr un
--   "divisor de frecuencia variable" de 1 a 512 BPM.
--
-- Comentarios adicionales:
--   Se puede encontrar más información en la siguiente dirección:
--   http://www.estadofinito.com/metronomo-en-vhdl-2/
--
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_rom_1_512BPM is
	GENERIC (
		NBITS   : integer := 28 -- Cantidad de bits que tiene cada registro en la ROM.
	);
	PORT (
        clk     : in  STD_LOGIC; -- Reloj de entrada de 50MHz.
        reset   : in  STD_LOGIC; -- Señal de reset.
		addr    : in  STD_LOGIC_VECTOR(8 downto 0); -- Dirección de la ROM.
        clk_out : out STD_LOGIC  -- Reloj de salida.
    );
end clk_rom_1_512BPM;

architecture Behavioral of clk_rom_1_512BPM is
	-- Señal de 3.125MHZ para entrar en divisor de frecuencia con ROM.
	signal clk3M125:  STD_LOGIC := '0';
	-- Señal intermedia para pasar de la ROM al componente del divisor.
	signal escala:    STD_LOGIC_VECTOR(NBITS-1 downto 0);
	-- Señal para habilitar lectura de la ROM.
	signal rom_en:    STD_LOGIC := '0';
begin
	-- La ROM se habilita siempre que no está el estado de reset.
	rom_en <= NOT reset;

	clk3M125Hz_i: entity work.clk3M125Hz(Behavioral)
		PORT MAP(clk, reset, clk3M125);
	rom512_28b_i: entity work.rom512_28b(Behavioral)
		PORT MAP(clk, rom_en, addr, escala);
	clk_rom_i: entity work.clk_rom(Behavioral)
		PORT MAP(clk3M125, reset, escala, clk_out);
end Behavioral;