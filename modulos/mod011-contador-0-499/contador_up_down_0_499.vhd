----------------------------------------------------------------------------------
-- Compaa:             Estado Finito
-- Ingeniero:          Carlos Ramos
-- 
-- Fecha de creacin:   2014/05/20 15:32:00
-- Nombre del mdulo:   contador_up_down_0_511 - Behavioral 
-- Comentarios adicionales: 
--   Contador de 9 bits (de 0 a 499), con valor después del reset igual a 59, y
--   con dos entradas: una para marcar incremento y otra para marcar decremento.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_up_down_0_499 is
    PORT(
        clk     : IN  STD_LOGIC;
        reset   : IN  STD_LOGIC;
        cnt_up  : IN  STD_LOGIC;
        cnt_down: IN  STD_LOGIC;
        contador: OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
end contador_up_down_0_499;

architecture Behavioral of contador_up_down_0_499 is
    signal temporal: UNSIGNED(8 DOWNTO 0) := "000111011";
begin
    proceso_contador: process (clk, reset, cnt_up, cnt_down) begin
        if (reset = '1') then
            temporal <= "000111011";
        elsif rising_edge(clk) then
            if (cnt_up = '1' AND temporal < 499) then
                temporal <= temporal + 1;
            elsif (cnt_down = '1' AND temporal > 0) then
                temporal <= temporal - 1;
            end if;
        end if;
    end process;
 
    contador <= STD_LOGIC_VECTOR(temporal);
end Behavioral;