#!/bin/sh
################################################################################
# Filename: ./postgres/init.sh                                                 #
# Path: ./sparkify-rdb/postgres                                                #
# Created Date: Saturday, July 10th 2021, 5:20:31 pm                           #
# Author: lkellermann                                                          #
#                                                                              #
# Copyright (c) 2021 CompanyName                                               #
# Shellscript to create a database in containeraized Postgresql.               #
#                                                                              #
# Script to create application database and its admin user. After this runs    #
# the script /mnt/create_tables.sh to create the following tables:             #
# - users (dimension).                                                         #
# - time (dimension).                                                          #
# - artists (dimension).                                                       #
# - songs (dimension).                                                         #
# - songplays (fact).                                                          #
################################################################################

export PGPASSWORD=$POSTGRES_PASSWORD # Export environment variables.

create_tables="/mnt/create_tables.sh" # Shell script to create tables.

# Log into psql, create admin user application and database application under it.
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER $APP_DB_USER WITH PASSWORD $APP_DB_PASS;
  CREATE DATABASE $APP_DB_NAME;
  GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;
  \q
EOSQL

# Run create_tables.sh script.
"$create_tables"
