LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY multiplexor_frecuencias_tb IS
END multiplexor_frecuencias_tb;

ARCHITECTURE behavior OF multiplexor_frecuencias_tb IS
	COMPONENT multiplexor_frecuencias
		PORT(
			clk : IN  std_logic;
			reset : IN  std_logic;
			selector : IN  std_logic_vector(2 downto 0);
			salida : OUT  std_logic
		);
	END COMPONENT;
	-- Entradas
	signal clk : std_logic := '0';
	signal reset : std_logic := '0';
	signal selector : std_logic_vector(2 downto 0) := (others => '0');
	-- Salidas
	signal salida : std_logic;
	-- Definición de reloj
	constant clk_period : time := 20 ns;
BEGIN
	-- Instancia de la unidad bajo prueba.
	uut: multiplexor_frecuencias PORT MAP (
		clk => clk,
		reset => reset,
		selector => selector,
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

	-- Proceso de estimulos.
	stim_proc: process
	begin
		-- Esta simulación puede tomar mucho tiempo (debido al tiempo de simulación).
		-- Se recomienda ejecutar por tramos o dejar corriendo durante la noche o periodo con baja actividad.
		reset <= '1';
		wait for 100 ns;
		reset <= '0';
		-- Inicio de prueba.
		selector <= "111"; -- Reloj de 4 Hz (tiempo por ciclo: 250ms)
		wait for 5000 ms;
		selector <= "110"; -- Reloj de 2 Hz (tiempo por ciclo: 500ms)
		wait for 5000 ms;
		selector <= "101"; -- Reloj de 1 Hz (tiempo por ciclo: 1s)
		wait for 5000 ms;
		selector <= "100"; -- Reloj de 0.5 Hz (tiempo por ciclo: 2s)
		wait for 5000 ms;
		selector <= "011"; -- Reloj de 0.25 Hz (tiempo por ciclo: 4s)
		wait for 5000 ms;
		selector <= "010"; -- Reloj de 0.125 Hz (tiempo por ciclo: 8s)
		wait for 5000 ms;
		selector <= "001"; -- Reloj de 0.0625 Hz (tiempo por ciclo: 16s)
		wait for 5000 ms;
		selector <= "000"; -- Nada
		wait for 5000 ms;
		
		wait;
	wait;
	end process;
END;