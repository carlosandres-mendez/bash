#!/bin/bash

shopt -s nocasematch

distro="$1"

case "$distro" in
	Ubuntu)
		echo "Sistema soportado en 32-bit.."
	;;
	Fedora)
		echo "Sistema soportado en 64-bit.."
	;;
	Debian)
		echo "Sistema soportado en 32-bit.. para \
arquitectura ARM"
	;;
	     *)
		echo "Distribución desconocida o no soportada"
esac


		
		
