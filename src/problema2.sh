#!/bin/bash

#Proyecto 2
#El ejercicio 2 grafica los recibos de luz y agua.  
#
#REQUIERE arhivos .xls con datos en el directorio ../problema2/

# Carlos Andres Mendez Rodriguez
# carlosandresucr@gmail.com

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



echo "" > $SALIDA_DATOS/datos.out

for archivo in `find $SALIDA_DATOS -name "*.csv"`
do
	echo "Procesando archivo csv $archivo"
	#cat $archivo | grep 'Luz' | awk -F "\",\"" '{print $2 }' >> $SALIDA_DATOS/datos.out
	#cat $archivo | grep 'Luz' | awk -F "\",\"" '{print $2 }' >> $SALIDA_DATOS/datos.out
	LUZ=$( cat $archivo | grep 'Luz' | awk -F "\",\"" '{print $2 }' )
	AGUA=$( cat $archivo | grep 'Agua' | awk -F "\",\"" '{print $2 }' )
	echo "$LUZ $AGUA" >> $SALIDA_DATOS/datos.out
done 2>error1.log

#: <<'END'
#cat $SALIDA_DATOS/datos.out 


#grafica las variables de interes utilizando la libreria gnuplot.
#En el eje x se pone los meses que corresponde y en el eje y el monto del recibo
#El grafico es una imagen que se genera y se almacena en el directorio que ejecute este script.
graficar()
{
	gnuplot << EOF 2> error1.log  #inicia el comando para graficar y especificar el archivo de error
	#set xdata time
	#set timefmt "%Y%m%d %H%M"
	#set xrange ["$FMT_BEGIN" : "$FMT_END"]
	set autoscale # genera automaticamente los rangos
	#set format x "$FMT_X_SHOW"
	set terminal png # espefica el formato de la imagen

	set xlabel "Mes"
	set ylabel "Colones"
	set output 'fig-agua.png'
	plot "$SALIDA_DATOS/datos.out" using 2 with lines title "Agua"

	set output 'fig-luz.png'
	set xrange ["1" : "3"] # Muestra el consumo electrico en los 3 primeros meses
	plot "$SALIDA_DATOS/datos.out" using 1 with lines title "Luz"
EOF
}

graficar

echo "Fin del programa"
exit 0

#END