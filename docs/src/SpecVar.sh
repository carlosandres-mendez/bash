#!/bin/bash

# Este script evalúa los distintos tipos de variables especiales y
# sólo recibe 3 argumentos máximo. De lo contrario, devuelve error.
#
# SYNOPSIS:
#	$ bash SpecVar.sh <op1> <op2> <op3>



#### Primero revisamos que el número de parámetros sea el correcto
# ------------------------------------------------------
# Revisión de argumentos

# Son tres argumentos
ARGS=3
ERROR_BADARGS=1

# Si el numer NO ES IGUAL a los argumentos esperados, entre
# al if. $# da el número de argumentos utilizados
if [ $# -ne "$ARGS" ]
then
  echo "Uso: `basename $0` <op1> <op2> <op3>"
  exit $ERROR_BADARGS
fi
# ------------------------------------------------------


# Inicio del programa

VAR1=1

echo "Los parametros del script fueron:"

## Diferencia entre $@ (es un arreglo) y $* (es un string separado por el IFS)
for param in "$@"; do
	echo "El parámetro $VAR1 es $param"
	let "VAR1=$VAR1+1"
done

echo "Valor de param $param"


# Notar que $* posee un "string" con los parámetros, no un arreglo como el
# caso anterior.

for param in "$*"; do
	echo "Lista de parámetros completa $param"
done

exit 0
