Divisor de frecuencia variable de 1 a 512BPM implementado con ROM
=====

Proyecto que utiliza el divisor de frecuencia con entrada para escala en conjunto con la ROM de 512 posiciones de 28 bits para almacenar los valores correspondientes a las frecuencias entre 1 y 512 BPM, siempre y cuando el reloj de entrada al divisor con entrada para escala sea de 3.125MHz.

Archivos
-----

	clk_rom_1_512BPM.vhd
	-- clk_rom.vhd
	-- rom512_28b.vhd
	-- clk3M125Hz.vhd
	** clk_rom_1_512BPM_tb.vhd
	## clk_rom_1_512BPM_basys2.ucf

[Entrada en el blog](http://www.estadofinito.com/metronomo-en-vhdl-2/)