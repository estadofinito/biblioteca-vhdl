----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2014/04/13 08:26:07
-- Nombre del módulo:   clk0_5Hz - Behavioral 
-- Comentarios adicionales: 
--   Implementación mediante aproximación, a caso con escala ajustada par (de 100000000 a 100000000).
--   La frecuencia fue ajustada al entero más próximo.
----------------------------------------------------------------------------------
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity clk0_5Hz is
    Port (
        clk     : in  STD_LOGIC; -- Reloj de entrada de 50000000Hz.
        reset   : in  STD_LOGIC;
        clk_out : out STD_LOGIC  -- Reloj de salida de 0.5Hz.
    );
end clk0_5Hz;
 
architecture Behavioral of clk0_5Hz is
    signal temporal: STD_LOGIC;
    signal contador: integer range 0 to 49999999 := 0;
begin
    divisor_frecuencia: process (clk, reset) begin
        if (reset = '1') then
            temporal <= '0';
            contador <= 0;
        elsif rising_edge(clk) then
            if (contador = 49999999) then
                temporal <= NOT(temporal);
                contador <= 0;
            else
                contador <= contador + 1;
            end if;
        end if;
    end process;
 
    clk_out <= temporal;
end Behavioral;