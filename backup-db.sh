#!/bin/bash
set -e

DBNAME="database"
FILENAME="/home/database.sql"

mysqldump -uadmin -p`cat /etc/psa/.psa.shadow` $DBNAME > $FILENAME



