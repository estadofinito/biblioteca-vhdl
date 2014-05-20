library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8a1 is
	PORT (
		entrada : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		selector: IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		salida  : OUT STD_LOGIC
	);
end mux8a1;

architecture Behavioral of mux8a1 is
begin
	salida <= entrada(0) when (selector = "000") else
	          entrada(1) when (selector = "001") else
			  entrada(2) when (selector = "010") else
			  entrada(3) when (selector = "011") else
			  entrada(4) when (selector = "100") else
			  entrada(5) when (selector = "101") else
			  entrada(6) when (selector = "110") else
			  entrada(7);
end Behavioral;