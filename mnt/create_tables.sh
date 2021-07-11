#!/bin/sh
################################################################################
# Filename: ./mnt/create_tables.sh                                             #
# Path: ./mnt                                                                  #
# Created Date: Saturday, July 10th 2021, 8:43:59 pm                           #
# Author: lkellermann                                                          #
#                                                                              #
# Copyright (c) 2021 CompanyName                                               #
################################################################################

path="$(pwd)/create"
users=$(cat "$path/users.sql")
time=$(cat "$path/time.sql")
artists=$(cat "$path/artists.sql")
songs=$(cat "$path/songs.sql")
songplays=$(cat "$path/songplays.sql")

# Log into psql, create admin user application and database to this user.
psql -v ON_ERROR_STOP=1 --username "$APP_DB_USER" --dbname "$APP_DB_NAME" <<-EOSQL
  $users
  $time
  $artists
  $songs
  $songplays
  \q
EOSQL
