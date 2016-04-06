#!/bin/bash

#Proyecto 3

DATOS="../problema3/Datos"

SALIDA_DATOS="../problema3/datos_csv/datos.out"

mkdir ../problema3/datos_csv

echo "Procesando archivo Datos"
#: <<'END'

cat $DATOS | awk -F "," '{print $1 " " $4 " " $5 " " $9 " " $11 " " $12 " " $13 " " $14 " " $15 " " $16}' | tr -d '"' >> $SALIDA_DATOS
#echo "$LUZ $AGUA" >> $SALIDA_DATOS/datos.out
#| tail -n 2400


#cat $SALIDA_DATOS/datos.out 

#

#FMT_BEGIN="20110205 0000"
#FMT_END="20110209 0200"
FMT_X_SHOW="%d" # Mostrar solo el dia en la fecha del eje x

graficar()
{
	gnuplot << EOF 2> error1.log
	set xdata time
	set timefmt "%Y-%m-%d"
	#set xrange ["$FMT_BEGIN" : "$FMT_END"]
	set autoscale
	set format x "$FMT_X_SHOW"
	set terminal png

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

