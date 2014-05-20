library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexor_frecuencias is
	PORT (
		clk     : IN  STD_LOGIC;
		reset   : IN  STD_LOGIC;
		selector: IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		salida  : OUT STD_LOGIC
	);
end multiplexor_frecuencias;

architecture Behavioral of multiplexor_frecuencias is
	COMPONENT mux8a1 IS
		PORT (
			entrada : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
			selector: IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
			salida  : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT clk0_0625Hz IS PORT (clk: IN STD_LOGIC; reset: IN STD_LOGIC; clk_out: OUT STD_LOGIC); END COMPONENT;
	COMPONENT clk0_125Hz  IS PORT (clk: IN STD_LOGIC; reset: IN STD_LOGIC; clk_out: OUT STD_LOGIC); END COMPONENT;
	COMPONENT clk0_25Hz   IS PORT (clk: IN STD_LOGIC; reset: IN STD_LOGIC; clk_out: OUT STD_LOGIC); END COMPONENT;
	COMPONENT clk0_5Hz    IS PORT (clk: IN STD_LOGIC; reset: IN STD_LOGIC; clk_out: OUT STD_LOGIC); END COMPONENT;
	COMPONENT clk1Hz      IS PORT (clk: IN STD_LOGIC; reset: IN STD_LOGIC; clk_out: OUT STD_LOGIC); END COMPONENT;
	COMPONENT clk2Hz      IS PORT (clk: IN STD_LOGIC; reset: IN STD_LOGIC; clk_out: OUT STD_LOGIC); END COMPONENT;
	COMPONENT clk4Hz      IS PORT (clk: IN STD_LOGIC; reset: IN STD_LOGIC; clk_out: OUT STD_LOGIC); END COMPONENT;
	
	signal clks : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"00";
begin
	clks(0) <= '0';
	clk0_0625Hz_i: clk0_0625Hz PORT MAP(clk, reset, clks(1));
	clk0_125Hz_i:  clk0_125Hz  PORT MAP(clk, reset, clks(2));
	clk0_25Hz_i:   clk0_25Hz   PORT MAP(clk, reset, clks(3));
	clk0_5Hz_i:    clk0_5Hz    PORT MAP(clk, reset, clks(4));
	clk1Hz_i:      clk1Hz      PORT MAP(clk, reset, clks(5));
	clk2Hz_i:      clk2Hz      PORT MAP(clk, reset, clks(6));
	clk4Hz_i:      clk4Hz      PORT MAP(clk, reset, clks(7));
	
	mux8a1_i: mux8a1 PORT MAP(clks, selector, salida);
end Behavioral;