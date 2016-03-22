#!/bin/bash

# Ejemplo #2 de Case en Bash.

ESPACIO=`df | awk '{print $5}' | grep -v Use | sort -n | tail -1 | cut -d "%" --f "1"`

#echo $ESPACIO
case $ESPACIO in
	[1-6]*)
		MENSAJE="Uso bajo de almacenamiento"
	;;
	[7-8]*)
		MENSAJE="Hay una partición medio llena. Tamaño=$ESPACIO%"
	;;
	9[0-5])
		MENSAJE="El sistema pronto colapsará. Tamaño=$ESPACIO%"
	;;
	*)
		MENSAJE="El sistema no tiene sistema de archivos"
esac

echo $MENSAJE | mail -s "Reporte de espacio en disco`date`" andres580@hotmail.com

exit 0
