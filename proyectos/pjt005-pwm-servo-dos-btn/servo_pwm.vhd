----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2012/12/18 12:38:52
-- Nombre del módulo:   servo_pwm - Behavioral
-- Descripción: 
--   Controlador en VHDL para servomotor con las siguientes especificaciones:
--       Frecuencia de actualización de 20ms.
--       128 estados posibles.
--       Ancho de pulso entre 0.5ms y 2.5ms.
--
--   NOTA: Para cumplir con las especificaciones mencionadas arriba debe recibir
--   una señal de reloj de 64kHz.Favor de consultar las URL mencionadas debajo
--   para conocer más acerca de los cálculos relacionados al diseño.
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
use IEEE.NUMERIC_STD.ALL;
 
entity servo_pwm is
    PORT (
        clk   : IN  STD_LOGIC;
        reset : IN  STD_LOGIC;
        pos   : IN  STD_LOGIC_VECTOR(6 downto 0);
        servo : OUT STD_LOGIC
    );
end servo_pwm;
 
architecture Behavioral of servo_pwm is
    -- Contador de 0 a 1279.
    signal cnt : unsigned(10 downto 0);
    -- Señal temporal para generar el PWM.
    signal pwmi: unsigned(7 downto 0);
begin
    -- Valor mínimo debe ser de 0.5ms.
    pwmi <= unsigned('0' & pos) + 32;
    -- Proceso del contador, de 0 a 1279.
    contador: process (reset, clk) begin
        if (reset = '1') then
            cnt <= (others => '0');
        elsif rising_edge(clk) then
            if (cnt = 1279) then
                cnt <= (others => '0');
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
    -- Señal de salida para el servomotor.
    servo <= '1' when (cnt < pwmi) else '0';
end Behavioral;