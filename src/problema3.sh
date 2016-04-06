#!/bin/bash

#Proyecto 3

DATOS="../problema3/Datos"

SALIDA_DATOS="../problema3/datos_csv"

mkdir $SALIDA_DATOS

echo "Procesando archivo Datos"
#: <<'END'

cat $DATOS | tail -n 100 | awk -F "," '{print $1 " " $4 " " $5}' | tr -d '"' >> $SALIDA_DATOS/datos.out
#echo "$LUZ $AGUA" >> $SALIDA_DATOS/datos.out



#cat $SALIDA_DATOS/datos.out 

#

#FMT_BEGIN="20110205 0000"
#FMT_END="20110209 0200"
#FMT_X_SHOW="%d/%H"

graficar()
{
	gnuplot << EOF 2> error1.log
	set xdata time
	set timefmt "%Y-%m-%d"
	#set xrange ["$FMT_BEGIN" : "$FMT_END"]
	set autoscale
	#set format x "$FMT_X_SHOW"
	set terminal png

	set xlabel "Fecha"
	set ylabel "Indice de radiacion solar"
	set output '/var/www/ciem/fig-indice.png'
	#set xrange ["1" : "3"] # Muestra el consumo electrico en los 3 primeros meses
	plot "$SALIDA_DATOS/datos.out" using 1:3 with lines title "Variable no se que es", "$SALIDA_DATOS/datos.out" using 1:4 with lines title "Variable menos que se"
EOF
}

graficar

echo "Fin del programa"
exit 0

#END

