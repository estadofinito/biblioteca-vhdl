LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY clk200Hz_tb IS
END clk200Hz_tb;
 
ARCHITECTURE behavior OF clk200Hz_tb IS
    COMPONENT clk200Hz
    PORT(
        entrada : IN  std_logic;
        reset   : IN  std_logic;
        salida  : OUT std_logic
    );
    END COMPONENT;
 
    -- Entradas
    signal entrada : std_logic := '0';
    signal reset   : std_logic := '0';
    -- Salidas
    signal salida  : std_logic;
    constant entrada_t : time := 20 ns; 
BEGIN
    -- Instancia de la unidad bajo prueba.
    uut: clk200Hz PORT MAP (
        entrada => entrada,
        reset   => reset,
        salida  => salida
    );
 
    -- Definición del reloj.
    entrada_process :process
        begin
        entrada <= '0';
        wait for entrada_t / 2;
        entrada <= '1';
        wait for entrada_t / 2;
    end process;
 
    -- Procesamiento de estímulos.
    estimulos: process
    begin
        reset <= '1'; -- Condiciones iniciales.
        wait for 100 ns;
        reset <= '0'; -- ¡A trabajar!
        wait;
    end process;
END;