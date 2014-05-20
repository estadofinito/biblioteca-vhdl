Biblioteca acádemica de componentes en VHDL
=====

Este repositorio corresponde a una biblioteca de componentes o módulos en VHDL cuyo objetivo final es su implementación en FPGA o CPLD mediante la síntesis lógica.

La presente biblioteca se considera académica pues su principal propósito son pruebas de componentes fácilmente implementados en tarjetas como Basys2, además de que el código está desarrollado pensando más a nivel comportamental que a nivel registro-transferencia.

Asimismo, los componentes no están optimizados, ni en área ni en potencia y, por lo tanto, su fin útil se encuentra en el ámbito educativo.



Estructura del repositorio
-----

El código se divide en tres carpetas, correspondientes a su disposición en el blog de [Estado Finito](http://www.estadofinito.com/). Estas carpetas son:

* [**Módulos**](http://www.estadofinito.com/blog/). Corresponden a módulos desarrollados en VHDL, cuya explicación se encuentra en una de las entradas del blog. Los módulos corresponden a archivos individuales.
* [**Proyectos**](http://www.estadofinito.com/blog/). También desarrollados en las entradas del blog, corresponden a proyectos conformados por varios módulos de VHDL unidos.
* [**Otros proyectos**](http://www.estadofinito.com/proyectos/). Son proyectos similares al material expuesto en las entradas del blog, pero que no contienen explicación por ser una variación de lo previamente explicado.
* **Todos los archivos**. Esta carpeta contiene todos los archivos fuente desarrollados para *Estado Finito*, sin alguna estructura.

Dentro de cada carpeta (que no sea la de todos los archivos), se encuentra el código separado por carpetas, según desarrollador en diversas entradas o páginas en el blog. Cada una de las carpetas cuenta con su propio archivo README, cuya estructura básica es:

    * Nombre del módulo o proyecto.
      Descripción: Qué hace el módulo o proyecto.
         Archivos: archivo-de-mayor-jerarquía.vhd
                   -- módulo-más-pequeño-contenido-en-proyecto.vhd
                      -- otro-módulo-contenido-en-un-segundo-nivel.vhd
                   -- más-módulos-hijos-de-superior.vhd
                   ** banco-de-pruebas_tb.vhd
                   ## archivo-de-implementación.ucf
              URL: http://www.estadofinito.com/entrada-en-blog-con-detalles

Cualquier duda o pregunta al respecto, envíame un correo a [carlos@estadofinito.com](mailto:carlos@estadofinito.com) o visita mi blog sobre sistemas digitales en [Estado Finito](http://www.estadofinito.com/).



Contenido
-----



Los componentes que actualmente se encuentran en el repositorio, por orden cronológico inverso, son:

### Proyectos

* Convertidor de binario de 9 bits a BCD y siete segmentos.
* Divisor de frecuencia variable de 1 a 512BPM implementado con ROM.
* Controlador para servomotor con rango de operación de 0.5 a 2.5ms con dos botones.
* Controlador para servomotor con rango de operación de 0.5 a 2.5ms.
* Reloj digital.
* Controlador de siete segmentos completo para Basys2.
* Modulador de ancho de pulso para motor DC con 101 estados y divisor de frecuencia como reloj de entrada.



### Módulos

* Convertidor de binario de 9 bits a BCD de 11 bits (3 dígitos).
* Divisor de frecuencia con entrada para escala.
* ROM de 512 localidades de 28 bits.
* Contador de 0 a 127 con dos botones.
* Controlador para servomotor.
* Contador de horas y minutos para reloj digital.
* Multiplexor de frecuencia para siete segmentos en la Basys2.
* Decodificador de seis bits a siete segmentos.
* Modulador de ancho de pulso para motor DC con 101 estados.
* Divisor de frecuencia de 50MHz a 200Hz.



### Otros proyectos

* Controlador de siete segmentos completo para Basys2 (4 bits).
* Multiplexor de frecuencias