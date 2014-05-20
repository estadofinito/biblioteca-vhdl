LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bin2bcd9_tb IS
END bin2bcd9_tb;

ARCHITECTURE behavior OF bin2bcd9_tb IS  
	-- Declaración del componente de la unidad bajo prueba.
	COMPONENT bin2bcd9
		PORT(
			num_bin : IN  std_logic_vector(8 downto 0);
			num_bcd : OUT  std_logic_vector(10 downto 0)
		);
	END COMPONENT;

	-- Entradas.
	signal clk : std_logic := '0';
	signal num_bin : std_logic_vector(8 downto 0) := (others => '0');
	-- Salidas.
	signal num_bcd : std_logic_vector(10 downto 0);
	-- Definición de los relojes.
	constant clk_period : time := 20 ns;
BEGIN
	-- Instancia de la unidad bajo prueba.
	uut: bin2bcd9 PORT MAP (
		num_bin => num_bin,
		num_bcd => num_bcd
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
		wait for 100 ns;
		num_bin <= "000000001"; --   1, 000 0000 0001
		wait for 10 ms;
		num_bin <= "000000010"; --   2, 000 0000 0010
		wait for 10 ms;
		num_bin <= "000000100"; --   4, 000 0000 0100
		wait for 10 ms;
		num_bin <= "000001000"; --   8, 000 0000 1000
		wait for 10 ms;
		num_bin <= "000010000"; --  16, 000 0001 0110
		wait for 10 ms;
		num_bin <= "000100000"; --  32, 000 0011 0010
		wait for 10 ms;
		num_bin <= "001000000"; --  64, 000 0110 0100
		wait for 10 ms;
		num_bin <= "010000000"; -- 128, 001 0010 1000
		wait for 10 ms;
		num_bin <= "100000000"; -- 256, 010 0101 0110
		wait;
	end process;
END;