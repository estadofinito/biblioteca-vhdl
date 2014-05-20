LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY servo_pwm_clk64kHz_tb IS
END servo_pwm_clk64kHz_tb;
 
ARCHITECTURE behavior OF servo_pwm_clk64kHz_tb IS
    -- Unidad bajo prueba.
    COMPONENT servo_pwm_clk64kHz
        PORT(
            clk   : IN  std_logic;
            reset : IN  std_logic;
            pos   : IN  std_logic_vector(6 downto 0);
            servo : OUT std_logic
        );
    END COMPONENT;
 
    -- Entradas.
    signal clk  : std_logic := '0';
    signal reset: std_logic := '0';
    signal pos  : std_logic_vector(6 downto 0) := (others => '0');
    -- Salidas.
    signal servo : std_logic;
    -- Definición del reloj.
    constant clk_period : time := 10 ns;
BEGIN
    -- Instancia de la unidad bajo prueba.
    uut: servo_pwm_clk64kHz PORT MAP (
        clk => clk,
        reset => reset,
        pos => pos,
        servo => servo
    );
 
   -- Definición del proceso de reloj.
   clk_process :process begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;
 
    -- Procesamiento de estímulos.
    proceso_estimulos: process begin
        reset <= '1';
        wait for 50 ns;
        reset <= '0';
        wait for 50 ns;
        pos <= "0000000";
        wait for 20 ms;
        pos <= "0101000";
        wait for 20 ms;
        pos <= "1010000";
        wait for 20 ms;
        pos <= "1111000";
        wait for 20 ms;
        pos <= "1111111";
        wait;
    end process;
END;