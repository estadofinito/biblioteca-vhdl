----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2012/10/26 09:35:12
-- Nombre del módulo:   clk1Hz - Behavioral
-- Descripción: 
--   Divisor de frecuencia implementado con contadores. Este divisor de frecuencia
--   reduce la escala en un factor de 25000000 veces. En este caso, la frecuencia se
--   reduce de 50MHz de entrada a 1Hz a la salida.
--
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk1Hz is
    Port (
        entrada: in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        salida : out STD_LOGIC
    );
end clk1Hz;

architecture Behavioral of clk1Hz is
    signal temporal: STD_LOGIC;
    signal contador: integer range 0 to 24999999 := 0;
begin
    divisor_frecuencia: process (reset, entrada) begin
        if (reset = '1') then
            temporal <= '0';
            contador <= 0;
        elsif rising_edge(entrada) then
            if (contador = 24999999) then
                temporal <= NOT(temporal);
                contador <= 0;
            else
                contador <= contador+1;
            end if;
        end if;
    end process;
 
    salida <= temporal;
end Behavioral;