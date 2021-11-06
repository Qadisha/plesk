#!/bin/bash
set -e

FTP_USER="ftpusername"
FTP_PASS="ftppassword"
FTP_HOST="ftpserver"
FTP_PATH="ftppath"

plesk bin domain -l > domain_list.txt

while read domain; do
    echo "Executing backup : $domain"
    plesk bin pleskbackup --domains-name $domain -exclude-logs --output-file=ftp://${FTP_USER}:${FTP_PASS}@${FTP_HOST}/${FTP_PATH}/`date +%Y-%m-%d_%H-%M`_$domain.bak
done <domain_list.txt
