/***************************************************************************
 * Filename: /run/media/kellermann/files/git_repo/sparkify-rdb/src/insert/songs.sql
 * Path: /run/media/kellermann/files/git_repo/sparkify-rdb/src/insert
 * Created Date: Saturday, July 10th 2021, 3:20:40 pm
 * Author: lkellermann
 * 
 * Copyright (c) 2021 CompanyName
 *
 * Upsert statement for songs dimension table.
 ***************************************************************************/


insert into songs(
    song_id
    ,title
	,artist_id
	,year
	,duration
)
VALUES(
    %s
    , %s
    , %s
    , %s
    , %s
)
	on conflict(song_id) /* If an artist launch the same song at the same year in different locations, this will no problem. */  
    do nothing;