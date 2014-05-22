library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
  
ENTITY metronomo_tb IS
END metronomo_tb;
 
ARCHITECTURE behavior OF metronomo_tb IS 
	COMPONENT metronomo
		PORT(
            clk     : in  STD_LOGIC; -- Reloj de entrada de 50MHz.
            reset   : in  STD_LOGIC; -- Señal de reset.
            btn_inc : in  STD_LOGIC; -- Incrementa la cantidad de BPM.
            btn_dec : in  STD_LOGIC; -- Decrementa la cantidad de BPM.
            d7s     : out STD_LOGIC_VECTOR(7 downto 0);
            MUX     : out STD_LOGIC_VECTOR(3 downto 0);
            clk_out : out STD_LOGIC  -- Reloj de salida.
		);
	END COMPONENT;
	--Inputs
	signal clk     : STD_LOGIC := '0';
	signal reset   : STD_LOGIC := '0';
    signal btn_inc : STD_LOGIC := '0';
    signal btn_dec : STD_LOGIC := '0';
	--Outputs
    signal d7s     : STD_LOGIC_VECTOR(7 downto 0);
    signal MUX     : STD_LOGIC_VECTOR(3 downto 0);
	signal clk_out : std_logic;
	-- Clock period definitions
	constant clk_period : time := 20 ns;
BEGIN
	-- Instancia de la unidad bajo prueba.
	uut: metronomo PORT MAP (
		clk => clk,
		reset => reset,
        btn_inc => btn_inc,
        btn_dec => btn_dec,
		d7s => d7s,
        MUX => MUX,
		clk_out => clk_out
	);

	-- Clock process definitions
	clk_process :process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
 
	-- Proceso de estmulos.
	stim_proc: process
	begin		
		reset <= '1';
        btn_dec <= '1';
		wait for 100 ns;
		reset <= '0';
		wait;
	end process;
END;
