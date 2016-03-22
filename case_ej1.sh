#!/bin/bash

# Primer ejemplo de Case. Determina  si el script puede correr en una arquitectura
# determinada. Además, ignora los tamaños de las letras. Así, UbUntu, ubuntu, UBUNTU.

shopt -s nocasematch

distro="$1"

case "$distro" in
	Ubuntu)
		echo "Sistema soportado en 32 bits"
	;;
	Fedora)
		echo "Sistema soportado en 64 bits"
	;;
	Debian)
		echo "Sistema para ARM"
	;;
	*)
		echo "Sistema no soportado"
esac

exit 0
