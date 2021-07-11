/***************************************************************************
 * Filename: /run/media/kellermann/files/git_repo/sparkify-rdb/src/create/artists.sql
 * Path: /run/media/kellermann/files/git_repo/sparkify-rdb/src/create
 * Created Date: Saturday, July 10th 2021, 3:09:58 pm
 * Author: lkellermann
 * 
 * Copyright (c) 2021 CompanyName
 *
 * Create statement for artist dismension table.
 ***************************************************************************/

begin;
create table if not exists
artists(
	artist_id varchar primary key
	,artist_name text not null
	,artist_location text
	,artist_latitude float
	,artist_longitude float
);
commit;