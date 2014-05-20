----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2014/04/13 08:23:55
-- Nombre del módulo:   clk2Hz - Behavioral 
-- Comentarios adicionales: 
--   Implementación de forma exacta, a caso con escala par.
--   
----------------------------------------------------------------------------------
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity clk2Hz is
    Port (
        clk     : in  STD_LOGIC; -- Reloj de entrada de 50MHz.
        reset   : in  STD_LOGIC;
        clk_out : out STD_LOGIC  -- Reloj de salida de 2Hz.
    );
end clk2Hz;
 
architecture Behavioral of clk2Hz is
    signal temporal: STD_LOGIC;
    signal contador: integer range 0 to 12499999 := 0;
begin
    divisor_frecuencia: process (clk, reset) begin
        if (reset = '1') then
            temporal <= '0';
            contador <= 0;
        elsif rising_edge(clk) then
            if (contador = 12499999) then
                temporal <= NOT(temporal);
                contador <= 0;
            else
                contador <= contador + 1;
            end if;
        end if;
    end process;
 
    clk_out <= temporal;
end Behavioral;