----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2012/12/18 05:45:23
-- Nombre del módulo:   clk64kHz - Behavioral
-- Descripción: 
--   Divisor de frecuencia implementado con contadores. Este divisor de frecuencia
--   reduce la escala en un factor de 781 veces. En este caso, la frecuencia se
--   reduce de 50MHz de entrada a 64kHz a la salida.
--
--   La aplición especifica de este divisor es en conjunto con el controlador del
--   servomotor.
--
-- Comentarios adicionales:
--   Se puede encontrar más información en las siguientes direcciones:
--   http://www.estadofinito.com/divisor-frecuencia-vhdl/
--   http://www.estadofinito.com/servo-pwm-vhdl
--
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity clk64kHz is
    Port (
        entrada: in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        salida : out STD_LOGIC
    );
end clk64kHz;
 
architecture Behavioral of clk64kHz is
    signal temporal: STD_LOGIC;
    signal contador: integer range 0 to 780 := 0;
begin
    divisor_frecuencia: process (reset, entrada) begin
        if (reset = '1') then
            temporal <= '0';
            contador <= 0;
        elsif rising_edge(entrada) then
            if (contador = 780) then
                temporal <= NOT(temporal);
                contador <= 0;
            else
                contador <= contador + 1;
            end if;
        end if;
    end process;
 
    salida <= temporal;
end Behavioral;