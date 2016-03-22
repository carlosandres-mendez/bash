#!/bin/bash

#Este scripr evalua los distintos tipos de variables especiales y solo recibe
#3 argumentos. De lo contrario, devuelve error.

#SYNOPSIS:
#      $bash script.sh <op1> <op2> <op3>

###### Revisión de argumentos
#-------------------------------------------------

ARGS=3
ERROR_BADARGS=1

if [ $# -ne "$ARGS" ]
then 
   echo "Uso: bach $0 <op1> <op2> <op3>"
   exit $ERROR_BADARGS
fi

#-------------------------------------------------

VAR1=1
echo
echo "Los parámetros del script fueron: "
for parametros in "$@"; do
	echo "El parámetro $VAR1 es $parametros"
	let "VAR1=$VAR1+1"
done

echo "Fin del programa"
exit 0
