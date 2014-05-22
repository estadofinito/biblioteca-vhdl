----------------------------------------------------------------------------------
-- Compañía:           Estado Finito
-- Ingeniero:          Carlos Ramos
-- 
-- Fecha de creación:   2014/04/24 18:34:19
-- Nombre del módulo:   metronomo - Behavioral 
-- Comentarios adicionales: 
--   Este divisor de frecuencia toma sus valores de una memoria ROM que contiene
--   los valores de los contadores. Por lo tanto, el rango de frecuencias depende
--   de la ROM.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity metronomo is
	PORT (
        clk     : in  STD_LOGIC; -- Reloj de entrada de 50MHz.
        reset   : in  STD_LOGIC; -- Señal de reset.
		btn_inc : in  STD_LOGIC; -- Incrementa la cantidad de BPM.
		btn_dec : in  STD_LOGIC; -- Decrementa la cantidad de BPM.
		d7s     : out STD_LOGIC_VECTOR(7 downto 0);
		MUX     : out STD_LOGIC_VECTOR(3 downto 0);
        clk_out : out STD_LOGIC  -- Reloj de salida.
    );
end metronomo;

architecture Behavioral of metronomo is
    -- Señal para comunicación entre ROM y divisor con ROM.
	signal escala:    STD_LOGIC_VECTOR(27 downto 0);
    -- Señal para el reloj de 3.125MHz (como entrada a divisor con ROM).
	signal clk3M125:  STD_LOGIC := '0';
	-- Señal para el reloj de 5Hz (como entrada al contador).
	signal clk5Hz:  STD_LOGIC := '0';
    -- Bit para habilitar, o no, la lectura de la ROM.
	signal rom_en:    STD_LOGIC := '0';
    -- Señal para almacenar la dirección a leer de la ROM.
	signal direccion: STD_LOGIC_VECTOR(8 downto 0);
    -- Señal para almacenar la cantidad de BPM.
	signal bpm:       STD_LOGIC_VECTOR(8 downto 0);
    -- Señal para pasar un número binario a BCD.
	signal num_bcd:   STD_LOGIC_VECTOR(10 downto 0);
    -- Dígitos BCD para ser mostrados como siete segmentos.
	signal D0, D1, D2, D3: STD_LOGIC_VECTOR(3 downto 0);
begin
    -- Reloj de 3.125MHz, que será la entrada para el divisor
    -- de frecuencia implementado con la ROM.
	clk3M125Hz_i: entity work.clk3M125Hz(Behavioral)
		PORT MAP(clk, reset, clk3M125);

	-- Reloj de 200Hz, que será la entrada al contador (para evitar un
	-- conteo súper rápido que no se ve).
	clk5Hz_i: entity work.clk5Hz(Behavioral)
		PORT MAP(clk, reset, clk5Hz);
        
    -- Contador de 0 a 499, con valor inicial en 59 (equivalente en
    -- este sistema a 60BPM), que apunta a la dirección ROM.
    contador_dir_i: entity work.contador_up_down_0_499(Behavioral)
        PORT MAP(clk5Hz, reset, btn_inc, btn_dec, direccion);
	
    -- Divisor de frecuencia que entrega una salida de 1 a 512
    -- pulsos por minuto, según la dirección de la ROM.
    -- En general: BPM = DIRECCION + 1.
	clk_rom_i: entity work.clk_rom(Behavioral)
		PORT MAP(clk3M125, reset, escala, clk_out);
	rom512_28b_i: entity work.rom512_28b(Behavioral)
		PORT MAP(clk, rom_en, direccion, escala);
	
    -- Convertidor de binario a BCD a siete segmentos.
    -- Se encarga de recibir la cantidad de BPM en binario,
    -- convertirla a tres dígitos en BCD, y enviar esos datos
    -- a los visualizadores de siete segmentos.
    bin2bcd9_i: entity bin2bcd9(Behavioral)
		PORT MAP(bpm, num_bcd);
	d7s_i: entity work.siete_segmentos_4bits_completo(Behavioral)
		PORT MAP(clk, reset, D0, D1, D2, D3, d7s, MUX);

    -- La cantidad de BPM es igual a la dirección más uno.
	bpm <= direccion + 1;
    -- La ROM está habilitada siempre y cuando no esté en reset.
	rom_en <= NOT reset;
    -- Se asignan las señales que representarán los datos en siete segmentos.
	D3 <= "0000";
	D2 <= "0" & num_bcd(10 downto 8);
	D1 <= num_bcd(7 downto 4);
	D0 <= num_bcd(3 downto 0);
end Behavioral;