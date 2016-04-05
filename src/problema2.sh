#!/bin/bash

#Proyecto 2

DATOS=../problema2

SALIDA_DATOS=$DATOS/datos_csv

mkdir $SALIDA_DATOS

M=0

for archivo in `find $DATOS -name "*.xls"`
do
	echo "Procesando archivo $archivo"
	xls2csv $archivo > $SALIDA_DATOS/dato-$M.csv
	let M=M+1
done 2>error1.log



echo '' > $SALIDA_DATOS/datos.out

for archivo in `find $SALIDA_DATOS -name "*.csv"`
do
	echo "Procesando archivo csv $archivo"
	cat $archivo | grep 'Luz' | awk -F "\",\"" '{print $2 }' >> $SALIDA_DATOS/datos.out

done 2>error1.log

cat $SALIDA_DATOS/datos.out 

#: <<'END'

#FMT_BEGIN="20110205 0000"
#FMT_END="20110209 0200"
#FMT_X_SHOW="%d/%H"

graficar()
{
	gnuplot << EOF 2> error1.log
	#set xdata time
	#set timefmt "%Y%m%d %H%M"
	#set xrange ["$FMT_BEGIN" : "$FMT_END"]
	set autoscale
	#set format x "$FMT_X_SHOW"
	set terminal png
	set output '/var/www/ciem/fig2.png'
	plot "$SALIDA_DATOS/datos.out" using 1 with lines title "Luz"
EOF
}

graficar

echo "Fin del programa"
exit 0

#END