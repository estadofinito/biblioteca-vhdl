library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity siete_segmentos_4bits is
    PORT (
        entrada: IN  STD_LOGIC_VECTOR(3 downto 0);
        salida : OUT STD_LOGIC_VECTOR(7 downto 0)
    );
end siete_segmentos_4bits;

architecture Behavioral of siete_segmentos_4bits is
begin
    visualizador: process (entrada) begin
        case entrada is
            when "0000" => salida <= x"C0"; -- 0
            when "0001" => salida <= x"F9"; -- 1
            when "0010" => salida <= x"A4"; -- 2
            when "0011" => salida <= x"B0"; -- 3
            when "0100" => salida <= x"99"; -- 4
            when "0101" => salida <= x"92"; -- 5
            when "0110" => salida <= x"82"; -- 6
            when "0111" => salida <= x"F8"; -- 7
            when "1000" => salida <= x"80"; -- 8
            when "1001" => salida <= x"98"; -- 9
            when "1010" => salida <= x"88"; -- A
            when "1011" => salida <= x"83"; -- B
            when "1100" => salida <= x"C6"; -- C
            when "1101" => salida <= x"A1"; -- D
            when "1110" => salida <= x"86"; -- E
            when "1111" => salida <= x"8E"; -- F
            when others => salida <= x"FF"; -- Nada
        end case;
    end process;
end Behavioral;
