library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity siete_segmentos_4bits_completo is
    PORT (
        clk   : IN  STD_LOGIC;
        reset : IN  STD_LOGIC;
        D0    : IN  STD_LOGIC_VECTOR(3 downto 0);
        D1    : IN  STD_LOGIC_VECTOR(3 downto 0);
        D2    : IN  STD_LOGIC_VECTOR(3 downto 0);
        D3    : IN  STD_LOGIC_VECTOR(3 downto 0);
        salida: OUT STD_LOGIC_VECTOR(7 downto 0);
        MUX   : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
end siete_segmentos_4bits_completo;

architecture Behavioral of siete_segmentos_4bits_completo is
	COMPONENT clk200Hz IS
		PORT (
            entrada: IN  STD_LOGIC;
            reset  : IN  STD_LOGIC;
            salida : OUT STD_LOGIC
        );
    END COMPONENT;
    
    COMPONENT siete_segmentos_4bits IS
		PORT (
            entrada: IN  STD_LOGIC_VECTOR(3 downto 0);
            salida : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
    END COMPONENT;
    
    COMPONENT siete_segmentos_4bits_mux IS
        PORT (
            clk   : IN  STD_LOGIC;
            reset : IN  STD_LOGIC;
            D0    : IN  STD_LOGIC_VECTOR(3 downto 0);
            D1    : IN  STD_LOGIC_VECTOR(3 downto 0);
            D2    : IN  STD_LOGIC_VECTOR(3 downto 0);
            D3    : IN  STD_LOGIC_VECTOR(3 downto 0);
            salida: OUT STD_LOGIC_VECTOR(3 downto 0);
            MUX   : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    
    signal clk_out : STD_LOGIC := '0';
    signal digito  : STD_LOGIC_VECTOR(3 downto 0);
begin
    clk_i: clk200Hz PORT MAP(
        clk, reset, clk_out
    );
    
    mux_i: siete_segmentos_4bits_mux PORT MAP(
        clk_out, reset, D0, D1, D2, d3, digito, MUX
    );
    
    seg_i: siete_segmentos_4bits PORT MAP(
        digito, salida
    );
end Behavioral;
