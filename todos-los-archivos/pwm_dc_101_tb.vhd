----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2014/05/02 20:52:44
-- Nombre del módulo:   pwm_dc_101 - behavior
-- Descripción: 
--   Banco de pruebas para el módulo pwm_dc_101.vhd
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY pwm_dc_101_tb IS
END pwm_dc_101_tb;

ARCHITECTURE behavior OF pwm_dc_101_tb IS 
	-- Declaración del componente de la unidad bajo prueba (UUT).
	COMPONENT pwm_dc_101
		PORT(
			clk : IN  std_logic;
			reset : IN  std_logic;
			entrada : IN  std_logic_vector(6 downto 0);
			salida : OUT  std_logic
		);
	END COMPONENT;
	-- Entradas
	signal clk : std_logic := '0';
	signal reset : std_logic := '0';
	signal entrada : std_logic_vector(6 downto 0) := (others => '0');
	-- Salidas
	signal salida : std_logic;
	-- Definición del periodo de reloj.
	constant clk_period : time := 20 ns;
BEGIN
	-- Instancia de la unidad bajo prueba (UUT).
	uut: pwm_dc_101 PORT MAP (
		clk => clk,
		reset => reset,
		entrada => entrada,
		salida => salida
	);

	-- Definición del proceso de reloj.
	clk_process :process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;


	-- Proceso de estímulos.
	stim_proc: process
	begin		
		-- Estado de reset.
		reset <= '1';
		wait for 100 ns;
		reset <= '0';
		-- Simulación.
		entrada <= "0000000";      -- Porcentaje en 0%.
		wait for clk_period * 200; -- Esperamos dos ciclos completos.
		entrada <= "0000001";      -- Porcentaje en 1%.
		wait for clk_period * 200; -- Esperamos dos ciclos completos.
		entrada <= "0011110";      -- Porcentaje en 30%.
		wait for clk_period * 200; -- Esperamos dos ciclos completos.
		entrada <= "1010000";      -- Porcentaje en 80%.
		wait for clk_period * 200; -- Esperamos dos ciclos completos.
		entrada <= "1100011";      -- Porcentaje en 99%.
		wait for clk_period * 200; -- Esperamos dos ciclos completos.
		entrada <= "1100100";      -- Porcentaje en 100%.
		wait for clk_period * 200; -- Esperamos dos ciclos completos.
		entrada <= "1111000";      -- Porcentaje en 120%.
		wait for clk_period * 200; -- Esperamos dos ciclos completos.
		wait;
	end process;
END;