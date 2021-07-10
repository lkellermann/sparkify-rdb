/***************************************************************************
 * Filename: /run/media/kellermann/files/git_repo/sparkify-rdb/src/create/songs.sql
 * Path: /run/media/kellermann/files/git_repo/sparkify-rdb/src/create
 * Created Date: Saturday, July 10th 2021, 3:09:37 pm
 * Author: lkellermann
 * 
 * Copyright (c) 2021 CompanyName
 *
 * Create statement for songs dimension table.
 ***************************************************************************/


create table if not exists 
songs(
    song_id varchar primary key
	,title varchar not null
	,artist_id varchar not null  
	,year int
	,duration float not null
);