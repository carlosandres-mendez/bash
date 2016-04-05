#!/bin/bash

#Este script extrae archivos de excel y grafica datos.

DATOS=../hojasDatos

SALIDA_DATOS=$DATOS/datos_csv

mkdir $SALIDA_DATOS

M=0

for archivo in `find $DATOS -name "*.xls"`
do
	echo "Procesando archivo $archivo"
	xls2csv $archivo > $SALIDA_DATOS/dato-$M.csv
	let M=M+1
done 2>>error1.log

M=0

for archivo in `find $SALIDA_DATOS -name "*.csv"`
do
	echo "Procesando archivo csv $archivo"
	cat $archivo | awk -F "\",\"" '{print $1 " " $2 " " $3 " " $4 " " $5}' | grep -v Sensor | sed '1,$ s/"//g' > $SALIDA_DATOS/dato-$M.out
	let M=M+1
done 2>>error1.log

FMT_BEGIN="20110205 0000"
FMT_END="20110209 0200"
FMT_X_SHOW="%d/%H"

graficar()
{
	gnuplot << EOF 2> error1.log
	set xdata time
	set timefmt "%Y%m%d %H%M"
	#set xrange ["$FMT_BEGIN" : "$FMT_END"]
	set autoscale
	set format x "$FMT_X_SHOW"
	set terminal png
	set output '/var/www/ciem/fig.png'
	plot "../hojasDatos/datos_csv/dato-0.out" using 1:3 with lines title "sensor 1", "../hojasDatos/datos_csv/dato-0.out" using 1:4 with linespoints title "sensor 2"
EOF
}

graficar

echo "Fin del programa"
exit 0