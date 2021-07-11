/***************************************************************************
 * Filename: /run/media/kellermann/files/git_repo/sparkify-rdb/src/insert/artists.sql
 * Path: /run/media/kellermann/files/git_repo/sparkify-rdb/src/insert
 * Created Date: Saturday, July 10th 2021, 3:22:28 pm
 * Author: lkellermann
 * 
 * Copyright (c) 2021 CompanyName
 *
 * Upsert statement for artists dimension table.
 ***************************************************************************/


insert into artists(
    artist_id
    ,artist_name
    ,artist_location
    ,artist_latitude
	,artist_longitude
)
values(
    %s
    , %s
    , %s
    , %s
    , %s
)
    on conflict (artist_id) /* An artist can change its name or living place. In this cases, don't change anything.*/
    do nothing;