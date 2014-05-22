----------------------------------------------------------------------------------
-- Compañía:            Estado Finito
-- Ingeniero:           Carlos Ramos
-- 
-- Fecha de creación:   2012/07/30 12:15:56
-- Nombre del módulo:   siete_segmentos_mux - Behavioral
-- Descripción: 
--   Multiplexor (de frecuencia) para mostrar un valor diferente en cada uno de
--   los visualizadores de siete segmentos. Esto se logra activando solamente un
--   visualizador a la vez y mandar el dato correspondiente. Si la frecuencia es
--   mayor a 16Hz por visualizador, no habrá parpadeo perceptible.
--   Diseñado para Basys2 de Digilent.
-- Comentarios adicionales:
--   Se puede encontrar más información en la siguiente dirección:
--   http://www.estadofinito.com/multiplexores-siete-segmentos/
-- Revisión:
--   Revisión 0.01 - Archivo creado.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity siete_segmentos_mux is
    PORT (
        clk   : IN  STD_LOGIC;
        reset : IN  STD_LOGIC;
        D0    : IN  STD_LOGIC_VECTOR(5 downto 0);  --Primer dígito.
        D1    : IN  STD_LOGIC_VECTOR(5 downto 0);  --Segundo dígito.
        D2    : IN  STD_LOGIC_VECTOR(5 downto 0);  --Tercer dígito.
        D3    : IN  STD_LOGIC_VECTOR(5 downto 0);  --Cuarto dígito.
        salida: OUT STD_LOGIC_VECTOR(5 downto 0);  --Salida del multiplexor (valor a desplegar).
        MUX   : OUT STD_LOGIC_VECTOR(3 downto 0)   --Valor que define cual dígito se va a mostrar.
    );
end siete_segmentos_mux;
 
architecture Behavioral of siete_segmentos_mux is
    type estados is (rst, v0, v1, v2, v3);
    signal estado : estados;
begin
    visualizadores: process (reset, clk) begin
        if (reset = '1') then
            estado <= rst;
            MUX <= x"F";
            salida <= "111111";
        elsif rising_edge(clk) then
            case estado is
                when v0 =>
                    salida <= D3;
                    MUX <= "1110";
                    estado <= v1;
                when v1 =>
                    salida <= D2;
                    MUX <= "1101";
                    estado <= v2;
                when v2 =>
                    salida <= D1;
                    MUX <= "1011";
                    estado <= v3;
                when others =>
                    salida <= D0;
                    MUX <= "0111";
                    estado <= v0;
            end case;
        end if;
    end process;
end Behavioral;