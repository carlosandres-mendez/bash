#!/bin/sh
#
# -*- ENCODING: UTF-8 -*-
#
# Este programa es software libre. Puede redistribuirlo y/o
# modificarlo bajo los términos de la Licencia Pública General
# de GNU según es publicada por la Free Software Foundation,
# bien de la versión 2 de dicha Licencia o bien (según su
# elección) de cualquier versión posterior.
#
# Este programa se distribuye con la esperanza de que sea
# útil, pero SIN NINGUNA GARANTÍA, incluso sin la garantía
# MERCANTIL implícita o sin garantizar la CONVENIENCIA PARA UN
# PROPÓSITO PARTICULAR. Para más detalles, véase la Licencia
# Pública General de GNU.
#
# Copyleft 2012, DesdeLinux.net
# Author: KZKG^Gaara <kzkggaara@desdelinux.net> <http://desdelinux.net>
#

NAME="VPS_Backup-Script"		# Nombre script.
#Descripción:				Script de backup de files y DBs del VPS 
: ${VERSION:=0.1}			# Versión script.
: ${DATE:=$(date +'%Y-%m-%d')}		# Variable para Fecha.
: ${TIME:=$(date +'%R')}		# Variable para Hora.
: ${WORK_DIR:=/home/backups/$DATE}		# Directorio de trabajo actual.
: ${LOG_FILE:=/home/backups/$DATE/record.log}	# Archivo de log.
: ${ADMIN1a:=admin@midominio.net}		# Email de Administrador No.1
: ${ADMIN1b:=mi.correo@gmail.com}		# Email de Administrador No.1
: ${ADMIN2a:=webmaster@midominio.net}		# Email de Administrador No.2
: ${ADMIN2b:=email.webmaster@riseup.net}	# Email de Administrador No.2
: ${LINE:="-----------------------------------------------------------------"}
: ${DB_PASS:=dbpasswordyeah}		# Password de MySQL.

# Creando directorio donde se trabajará, si es que no existe.
if [ ! -d "`dirname $LOG_FILE`" ] ; then mkdir -p "`dirname $LOG_FILE`"; fi

# Cambiando a directorio donde trabajaremos.
cd $WORK_DIR

# Copiando /ETC/ hacia directorio de trabajo actual.
cp -Rv /etc/ $WORK_DIR > $LOG_FILE
echo $LINE >> $LOG_FILE

# Creando carpeta para logs.
mkdir $WORK_DIR/logs

# Copiando LOGs.
cp /var/log/apache2/ $WORK_DIR/logs/ -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
cp /var/log/aptitud* $WORK_DIR/logs/ -v >> $LOG_FILE && echo $LINE >> $LOG_FILE
cp /var/log/auth* $WORK_DIR/logs/ -v >> $LOG_FILE && echo $LINE >> $LOG_FILE
cp /var/log/daemon* $WORK_DIR/logs/ -v >> $LOG_FILE && echo $LINE >> $LOG_FILE
cp /var/log/dmes* $WORK_DIR/logs/ -v >> $LOG_FILE && echo $LINE >> $LOG_FILE
cp /var/log/kern* $WORK_DIR/logs/ -v >> $LOG_FILE && echo $LINE >> $LOG_FILE
cp /var/log/mail* $WORK_DIR/logs/ -v >> $LOG_FILE && echo $LINE >> $LOG_FILE
cp /var/log/message* $WORK_DIR/logs/ -v >> $LOG_FILE && echo $LINE >> $LOG_FILE
cp /var/log/mysql/ $WORK_DIR/logs/ -Rv >> $LOG_FILE && echo $LINE >> $LOG_FILE
cp /var/log/mysql.* $WORK_DIR/logs/ -v >> $LOG_FILE && echo $LINE >> $LOG_FILE
cp /var/log/sys* $WORK_DIR/logs/ -v >> $LOG_FILE && echo $LINE >> $LOG_FILE

# Creando carpeta para DBs.
mkdir $WORK_DIR/dbs

# Exportando DBs.
mysqldump --opt -hlocalhost -uroot -p"$DB_PASS" misitio > "$WORK_DIR/dbs/misitio.sql"
mysqldump --opt -hlocalhost -uroot -p"$DB_PASS" mysql > "$WORK_DIR/dbs/mysql.sql"
mysqldump --opt -hlocalhost -uroot -p"$DB_PASS" blogdb > "$WORK_DIR/dbs/blogdb.sql"
mysqldump --opt -hlocalhost -uroot -p"$DB_PASS" pastebin > "$WORK_DIR/dbs/pastebin.sql"

# Saliendo un nivel más arriba (/home/backups/).
cd ..

# Comprimiendo directorio de trabajo actual.
#tar czvf "$DATE.tar.gz" "$DATE"
rar a $DATE.rar -hpPASSWORD $WORK_DIR >> $LOG_FILE && echo $LINE >> $LOG_FILE

# Preparando información para enviar por email.
touch data.info
echo "El archivo $DATE.rar tiene un tamaño de:" > data.info
du -bsh $DATE.rar >> data.info
echo $LINE >> data.info
cat $LOG_FILE >> data.info
tar czvf data.info.tar.gz data.info

# Eliminando directorio una vez comprimido.
rm -R "$WORK_DIR"

# Enviando emails a administradores.
mail -s "[VPS] | Status de Backup." $ADMIN1a < data.info.tar.gz
mail -s "[VPS] | Status de Backup." $ADMIN1b < data.info.tar.gz
mail -s "[VPS] | Status de Backup." $ADMIN2a < data.info.tar.gz
mail -s "[VPS] | Status de Backup." $ADMIN2b < data.info.tar.gz

# Haciendo copia por SSH hacia cuenta en otro servidor o hosting.
#scp -P 922 "/home/backups/$DATE.rar" account@serverhosting.com:/home/backups/

echo "                  #######################"
echo "                  ## BACKUP REALIZADO! ##"
echo "                  #######################"

# Fin del script.
exit 0