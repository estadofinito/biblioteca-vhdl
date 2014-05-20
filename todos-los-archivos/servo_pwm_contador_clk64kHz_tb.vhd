LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY servo_pwm_contador_clk64kHz_tb IS
END servo_pwm_contador_clk64kHz_tb;

ARCHITECTURE behavior OF servo_pwm_contador_clk64kHz_tb IS 
	-- Unidad bajo prueba.
	COMPONENT servo_pwm_contador_clk64kHz
		PORT(
			clk   : IN  std_logic;
			reset : IN  std_logic;
			cnt_up: IN  std_logic;
			cnt_dn: IN  std_logic;
			servo : OUT std_logic
		);
	END COMPONENT;

	-- Entradas.
	signal clk : std_logic := '0';
	signal reset : std_logic := '0';
	signal cnt_up : std_logic := '0';
	signal cnt_dn : std_logic := '0';
	-- Salidas.
	signal servo : std_logic;
	-- Definición del reloj.
	constant clk_period : time := 10 ns;
BEGIN
	-- Instancia de la unidad bajo prueba.
	uut: servo_pwm_contador_clk64kHz PORT MAP (
		clk => clk,
		reset => reset,
		cnt_up => cnt_up,
		cnt_dn => cnt_dn,
		servo => servo
	);

	-- Definición del proceso de reloj.
	clk_process :process
	begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
	end process;


	-- Procesamiento de estímulos.
	proceso_estimulos: process begin
		-- Crear condición de reset.
		reset <= '1';
        wait for 50 ns;
        reset <= '0';
		-- Esperar poco menos de dos ciclos.
		wait for 39 ms;
		-- Crear el estímulo.
		cnt_up <= '1';
		wait for 15 us; -- Tiempo a editar.
		--cnt_up <= '0';
		wait;
	end process;
END;