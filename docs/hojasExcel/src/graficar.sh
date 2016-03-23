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


