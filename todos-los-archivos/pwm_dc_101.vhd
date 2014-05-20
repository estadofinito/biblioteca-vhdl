----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2014/05/03 02:47:32
-- Nombre del módulo:   pwm_dc_101 - Behavioral 
-- Descripción: 
--   Controlador para motor DC de 101 posiciones. Las posiciones corresponden a un
--   porcentaje entre 0 y 100% del ciclo de trabajo, con un incremento del 1% 
--   entre cada uno de los elementos.
--
--   NOTA: En este módulo no se toma en cuenta la frecuencia de entrada (es decir,
--   se asume que la frecuencia de entrada en 'clk' es la correcta para el motor).
--
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity pwm_dc_101 is
    PORT(
        clk    : IN  STD_LOGIC;
        reset  : IN  STD_LOGIC;
        entrada: IN  STD_LOGIC_VECTOR(6 downto 0);
        salida : OUT STD_LOGIC
    );
end pwm_dc_101;
 
architecture Behavioral of pwm_dc_101 is
    signal cnt : UNSIGNED(6 downto 0);
begin
    contador: process (clk, reset, entrada) begin
        if reset = '1' then
            cnt <= (others => '0');
        elsif rising_edge(clk) then
            if cnt = 99 then
                cnt <= (others => '0');
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
    -- Asignación de señales --
    salida <= '1' when (cnt < UNSIGNED(entrada)) else '0';
end Behavioral;