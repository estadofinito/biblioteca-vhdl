----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2012/07/30 20:12:36
-- Nombre del módulo:   siete_segmentos_completo - Behavioral
-- Descripción: 
--   Se encarga de unir el decodificador de seis bits a siete segmentos, el 
--   divisor de frecuencia de 50MHz a 200Hz y el multiplexor para visualizadores
--   con el fin de mostrar un digíto diferente en cada uno de los visualizadores
--   de la tarjeta Basys2, a una frecuencia de 200Hz.
-- Comentarios adicionales:
--   Se puede encontrar más información en la siguiente dirección:
--   http://www.estadofinito.com/multiplexores-siete-segmentos/
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity siete_segmentos_completo is
    PORT (
        clk   : IN  STD_LOGIC;
        reset : IN  STD_LOGIC;
        D0    : IN  STD_LOGIC_VECTOR(5 downto 0);
        D1    : IN  STD_LOGIC_VECTOR(5 downto 0);
        D2    : IN  STD_LOGIC_VECTOR(5 downto 0);
        D3    : IN  STD_LOGIC_VECTOR(5 downto 0);
        salida: OUT STD_LOGIC_VECTOR(7 downto 0);
        MUX   : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
end siete_segmentos_completo;
 
architecture Behavioral of siete_segmentos_completo is
    COMPONENT clk200Hz IS
        PORT (
            entrada: IN  STD_LOGIC;
            reset  : IN  STD_LOGIC;
            salida : OUT STD_LOGIC
        );
    END COMPONENT;
     
    COMPONENT siete_segmentos IS
        PORT (
            entrada: IN  STD_LOGIC_VECTOR(5 downto 0);
            salida : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
    END COMPONENT;
     
    COMPONENT siete_segmentos_mux IS
        PORT (
            clk   : IN  STD_LOGIC;
            reset : IN  STD_LOGIC;
            D0    : IN  STD_LOGIC_VECTOR(5 downto 0);
            D1    : IN  STD_LOGIC_VECTOR(5 downto 0);
            D2    : IN  STD_LOGIC_VECTOR(5 downto 0);
            D3    : IN  STD_LOGIC_VECTOR(5 downto 0);
            salida: OUT STD_LOGIC_VECTOR(5 downto 0);
            MUX   : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
     
    signal clk_out : STD_LOGIC := '0';
    signal digito  : STD_LOGIC_VECTOR(5 downto 0);
begin
    clk_i: clk200Hz PORT MAP(
        clk, reset, clk_out
    );
     
    mux_i: siete_segmentos_mux PORT MAP(
        clk_out, reset, "000000", "000001", "000010", "000011", digito, MUX
    );
     
    seg_i: siete_segmentos PORT MAP(
        digito, salida
    );
end Behavioral;