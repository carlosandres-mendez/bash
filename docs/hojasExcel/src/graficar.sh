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
done 2>error1.log

M=0

for archivo in `find $SALIDA_DATOS -name "*.csv"`
do
	echo "Procesando archivo csv $archivo"
	cat $archivo | awk -F "\",\"" '{print $1 " " $2 " " $3 " " $4 " " $5}' | grep -v Sensor | sed '1,$ s/"//g' > $SALIDA_DATOS/dato-$M.out
	let M=M+1
done 2>error1.log

