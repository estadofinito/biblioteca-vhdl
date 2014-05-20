Controlador para servomotor con rango de operación de 0.5 a 2.5ms con dos botones
=====

Proyecto que utiliza un divisor de frecuencia de 50MHz a 64kHz como entrada para el control de un servomotor con rango de operación de 0.5 a 2.5ms, con una frecuencia de actualización de 20ms, con 128 posiciones disponibles. Para cambiar de posición se utilizan dos botones, uno para incrementar y otro para decrementar.

Archivos
-----

	servo_pwm_contador_clk64kHz.vhd
	-- servo_pwm.vhd
	-- contador_servo_pwm.vhd
	-- clk64kHz.vhd
	** servo_pwm_contador_clk64kHz_tb.vhd

[Entrada en el blog](http://www.estadofinito.com/control-servomotor-dos-botones/)