----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2012/12/18 18:01:59
-- Nombre del módulo:   servo_pwm_clk64kHz - Behavioral
-- Descripción: 
--   Unión del controlador de servomotor con el reloj de 64kHz.
--
-- Comentarios adicionales:
--   Se puede encontrar más información en la siguiente dirección:
--   http://www.estadofinito.com/servo-pwm-vhdl
--
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity servo_pwm_clk64kHz is
    PORT(
        clk  : IN  STD_LOGIC;
        reset: IN  STD_LOGIC;
        pos  : IN  STD_LOGIC_VECTOR(6 downto 0);
        servo: OUT STD_LOGIC
    );
end servo_pwm_clk64kHz;
 
architecture Behavioral of servo_pwm_clk64kHz is
    COMPONENT clk64kHz
        PORT(
            entrada: in  STD_LOGIC;
            reset  : in  STD_LOGIC;
            salida : out STD_LOGIC
        );
    END COMPONENT;
 
    COMPONENT servo_pwm
        PORT (
            clk   : IN  STD_LOGIC;
            reset : IN  STD_LOGIC;
            pos   : IN  STD_LOGIC_VECTOR(6 downto 0);
            servo : OUT STD_LOGIC
        );
    END COMPONENT;
 
    signal clk_out : STD_LOGIC := '0';
begin
    clk64kHz_map: clk64kHz PORT MAP(
        clk, reset, clk_out
    );
 
    servo_pwm_map: servo_pwm PORT MAP(
        clk_out, reset, pos, servo
    );
end Behavioral;