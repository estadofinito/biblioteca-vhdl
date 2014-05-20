Controlador para servomotor
=====

Módulo en VHDL que se encarga de controlar un servomotor con 128 posiciones. El control está diseñado para un servo con frecuencia de operación entre 0.5-2.5ms, y una frecuencia de actualización de 20ms, aunque dichas frecuencias sólo se logran si la entrada de reloj es de 64kHz.

Archivos
-----

	servo_pwm.vhd

[Entrada en el blog](http://www.estadofinito.com/servo-pwm-vhdl)