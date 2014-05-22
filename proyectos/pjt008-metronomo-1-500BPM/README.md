Metrónomo de 1 a 500 BPM, con cambio de frecuencia con dos botones
=====

Proyecto que utiliza el convertidor de nueve bits a BCD y, posteriormente, utiliza los once dígitos del BCD para mostrar el número en tres visualizadores de siete segmentos de la tarjeta Basys2.

Archivos
-----

	metronomo.vhd
	-- clk3M125Hz.vhd
	-- clk5Hz.vhd
	-- contador_up_down_0_499.vhd
	-- clk_rom.vhd
	-- rom512_28.vhd
	-- bin2bcd9.vhd
	-- siete_segmentos_4bits_completo.vhd
	   -- clk200Hz.vhd
	   -- siete_segmentos_4bits.vhd
	   -- siete_segmentos_4bits_mux.vhd
	## metronomo_basys2.ucf

[Entrada en el blog](http://www.estadofinito.com/metronomo-en-vhdl-3/)