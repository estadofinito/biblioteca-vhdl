----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2014/05/16 00:35:30
-- Nombre del módulo:   bin7seg - Behavioral 
-- Comentarios adicionales: 
--   Recibe un valor de 9 bits y lo convierte a BCD para enviarlo como dato a los
--   visualizadores de una tarjeta Basys2.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bin7seg is
	PORT (
        clk     : in  STD_LOGIC; -- Reloj de entrada de 50MHz.
        reset   : in  STD_LOGIC; -- Señal de reset.
		num_bin : in  STD_LOGIC_VECTOR(8 downto 0);
		d7s     : out STD_LOGIC_VECTOR(7 downto 0);
		MUX     : out STD_LOGIC_VECTOR(3 downto 0)
    );
end bin7seg;

architecture Behavioral of bin7seg is
	signal num_bcd: STD_LOGIC_VECTOR(10 downto 0);
	signal D0, D1, D2, D3: STD_LOGIC_VECTOR(3 downto 0);
begin
	d7s_i: entity work.siete_segmentos_4bits_completo(Behavioral)
		PORT MAP(clk, reset, D0, D1, D2, D3, d7s, MUX);
	bin2bcd9_i: entity bin2bcd9(Behavioral)
		PORT MAP(num_bin, num_bcd);

	D3 <= "0000";
	D2 <= "0" & num_bcd(10 downto 8);
	D1 <= num_bcd(7 downto 4);
	D0 <= num_bcd(3 downto 0);
end Behavioral;
