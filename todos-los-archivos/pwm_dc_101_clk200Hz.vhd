----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2014/05/03 21:52:52
-- Nombre del módulo:   pwm_dc_101_clk200Hz - Behavioral 
-- Descripción: 
--   Este proyecto corresponde a la unión del módulo de PWM para motor DC de 101
--   estados y el divisor de frecuencia de 50MHz a 200Hz.
--   En resumen, muestra cómo adaptar cualquier frecuencia como entrada (en este
--   caso fue 200Hz) dependiendo del motor a manipular.
--
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pwm_dc_101_clk200Hz is
    PORT(
        clk    : IN  STD_LOGIC;
        reset  : IN  STD_LOGIC;
        entrada: IN  STD_LOGIC_VECTOR(6 downto 0);
        salida : OUT STD_LOGIC
    );
end pwm_dc_101_clk200Hz;

architecture Behavioral of pwm_dc_101_clk200Hz is
    COMPONENT clk200Hz IS
        PORT (
            entrada: IN  STD_LOGIC;
            reset  : IN  STD_LOGIC;
            salida : OUT STD_LOGIC
        );
    END COMPONENT;
    
    COMPONENT pwm_dc_101 IS
        PORT(
            clk    : IN  STD_LOGIC;
            reset  : IN  STD_LOGIC;
            entrada: IN  STD_LOGIC_VECTOR(6 downto 0);
            salida : OUT STD_LOGIC
        );
    END COMPONENT;
    
    signal clk_out : STD_LOGIC := '0';
begin
    clk200Hz_i:   clk200Hz   PORT MAP(clk, reset, clk_out);
    pwm_dc_101_i: pwm_dc_101 PORT MAP(clk_out, reset, entrada, salida);
end Behavioral;