#!/bin/bash

# Script para probar el tamaño en el disco duro

espacio=`df -h | awk '{print $5}'  | grep -v Use | sort -n | tail -1 | cut -d "%" -f1 -`

echo $espacio

## Inicio de pruebas para los tamaños del disco
## Los brackets funcionan para especificar rangos. En el primer caso,
## si la variable $espacio va de 1*% a 6*%, por ejemplo 66%, se ejecuta
## el primer mensaje
case $espacio in
[1-6]*)
  Mensaje="Uso bajo de almacenamiento"
  ;;
[7-8]*)
  Mensaje="Hay una partición con aumento de espacio. Tamaño = $space % "
  ;;
9[1-5])
  Mensaje="Hay una partición realmente llena. Tamaño $space %"
  ;;
9[6-9])
  Mensaje="El sistema pronto colapsará.. $space %!"
  ;;
*)
  Mensaje="No aparece el almacenamiento del sistema, hay un error!!"
  ;;
esac

echo $Mensaje | mail -s "Reporte de espacio en disco `date`" csmcpyte
#echo $Mensaje

exit 0
