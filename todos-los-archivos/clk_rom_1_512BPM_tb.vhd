LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY clk_rom_1_512BPM_tb IS
END clk_rom_1_512BPM_tb;

ARCHITECTURE behavior OF clk_rom_1_512BPM_tb IS  
	-- Declaración del componente de la unidad bajo prueba (UUT).
	COMPONENT clk_rom_1_512BPM
		PORT(
			clk : IN  std_logic;
			reset : IN  std_logic;
			addr : IN  std_logic_vector(8 downto 0);
			clk_out : OUT  std_logic
		);
	END COMPONENT;
	-- Entradas.
	signal clk : std_logic := '0';
	signal reset : std_logic := '0';
	signal addr : std_logic_vector(8 downto 0) := (others => '0');
	-- Salidas.
	signal clk_out : std_logic;
	-- Definición de los periodos de reloj.
	constant clk_period : time := 20 ns;
BEGIN
	-- Instancia de la unidad bajo prueba (UUT).
	uut: clk_rom_1_512BPM PORT MAP (
		clk => clk,
		reset => reset,
		addr => addr,
		clk_out => clk_out
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
		-- Reset.
		reset <= '1';
		wait for 100 ns;
		reset <= '0';
		-- Esta simulación será larga, pues debe abarcar al menos 1 minuto
		-- para llegar a ver cómo se comportan las frecuencias reales.
		
		-- En esta simulación sólo se utilizarán los valores para 200 BPM
		-- y 300 BPM, durante 1 segundo cada una.
		addr <= "011000111"; -- 200BPM.
		wait for 1000 ms;   -- 5 segundos.
		addr <= "100101011"; -- 200BPM.
		-- Se estipula en la simulación que corra 2000ms.
		wait;
	end process;
END;