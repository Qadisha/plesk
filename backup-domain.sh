#!/bin/bash
set -e

DOMAIN="domainname"
FTP_USER="ftpusername"
FTP_PASS="ftppassword"
FTP_HOST="ftpserver"
FTP_PATH="ftppath"

plesk bin pleskbackup --domains-name ${DOMAIN} -exclude-logs --output-file=ftp://${FTP_USER}:${FTP_PASS}@${FTP_HOST}/${FTP_PATH}/`date +%Y-%m-%d_%H-%M`_${DOMAIN}.raw



