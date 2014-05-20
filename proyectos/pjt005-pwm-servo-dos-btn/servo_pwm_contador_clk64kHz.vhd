----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2013/06/01 14:08:49
-- Nombre del módulo:   servo_pwm_contador_clk64kHz - Behavioral
-- Descripción: 
--   Unión del controlador de servomotor con el reloj de 64kHz, y el contador de
--   dos botones para cambio de estado.
--
-- Comentarios adicionales:
--   Se puede encontrar más información en las siguientes direcciones:
--   http://www.estadofinito.com/control-servomotor-dos-botones/
--   http://www.estadofinito.com/servo-pwm-vhdl
--
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity servo_pwm_contador_clk64kHz is
    PORT(
        clk   : IN  STD_LOGIC;
        reset : IN  STD_LOGIC;
		cnt_up: IN  STD_LOGIC;
		cnt_dn: IN  STD_LOGIC;
        servo : OUT STD_LOGIC
    );
end servo_pwm_contador_clk64kHz;
 
architecture Behavioral of servo_pwm_contador_clk64kHz is
    COMPONENT clk64kHz
        PORT(
            entrada: in  STD_LOGIC;
            reset  : in  STD_LOGIC;
            salida : out STD_LOGIC
        );
    END COMPONENT;
     
    COMPONENT servo_pwm
        PORT (
            clk   : IN  STD_LOGIC;
            reset : IN  STD_LOGIC;
            pos   : IN  STD_LOGIC_VECTOR(6 downto 0);
            servo : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT contador_servo_pwm
        PORT (
			clk   : IN  STD_LOGIC;
			reset : IN  STD_LOGIC;
			cnt_up: IN  STD_LOGIC;
			cnt_dn: IN  STD_LOGIC;
			pos   : OUT STD_LOGIC_VECTOR(6 downto 0)
        );
    END COMPONENT;
     
    signal clk_out : STD_LOGIC := '0';
	signal pos_out : STD_LOGIC_VECTOR(6 downto 0);
begin
    clk64kHz_map: clk64kHz PORT MAP(
        clk, reset, clk_out
    );

	contador_servo_pwm_map: contador_servo_pwm PORT MAP(
		clk_out, reset, cnt_up, cnt_dn, pos_out
	);
     
    servo_pwm_map: servo_pwm PORT MAP(
        clk_out, reset, pos_out, servo
    );
end Behavioral;