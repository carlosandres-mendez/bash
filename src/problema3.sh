#!/bin/bash

#Proyecto 3
#El ejercicio 3 contiene el famoso archivo de Datos de la seccion 3, grafica algunas variables del indice de radiacion solar 
#
#REQUIERE el arhivo de Datos en el directorio ../problema3/

# Carlos Andres Mendez Rodriguez
# carlosandresucr@gmail.com

DATOS="../problema3/Datos"

SALIDA_DATOS="../problema3/datos_csv/datos.out"

mkdir ../problema3/datos_csv

echo "Procesando archivo Datos"
#: <<'END'

# Se filtran las columnas de datos interesadas del archivo Datos. 
cat $DATOS | awk -F "," '{print $1 " " $4 " " $5 " " $9 " " $11 " " $12 " " $13 " " $14 " " $15 " " $16}' | tr -d '"' >> $SALIDA_DATOS


FMT_X_SHOW="%d" # Mostrar solo el dia en la fecha del eje x

#grafica las variables de interes utilizando la libreria gnuplot.
#En el eje x se pone los dias y en el eje y los valores de las variables
#El grafico es una imagen que se genera y se almacena en el directorio que ejecute este script.
graficar()
{
	gnuplot << EOF 2> error1.log #inicia el comando para graficar y especificar el archivo de error
	set xdata time
	set timefmt "%Y-%m-%d"
	#set xrange ["$FMT_BEGIN" : "$FMT_END"]
	set autoscale # genera automaticamente los rangos
	set format x "$FMT_X_SHOW"
	set terminal png # espefica el formato de la imagen

	set xlabel "Fecha"
	set ylabel "Indice de radiacion solar"
	set output 'fig-indice.png'
	#set xrange ["1" : "3"] # Muestra el consumo electrico en los 3 primeros meses
	plot "$SALIDA_DATOS" using 1:3 with lines title "Var 1", "$SALIDA_DATOS" using 1:4 with lines title "Var 2", "$SALIDA_DATOS" using 1:5 with lines title "Var 3", "$SALIDA_DATOS" using 1:7 with lines title "Var 4", "$SALIDA_DATOS" using 1:8 with lines title "Var 5", "$SALIDA_DATOS" using 1:9 with lines title "Var 6", "$SALIDA_DATOS" using 1:10 with lines title "Var 7", "$SALIDA_DATOS" using 1:11 with lines title "Var 8", "$SALIDA_DATOS" using 1:12 with lines title "Var 9"
EOF
}

graficar

echo "Fin del programa"
exit 0

#END

