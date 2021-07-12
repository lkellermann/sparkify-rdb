/***************************************************************************
 * Filename: /run/media/kellermann/files/git_repo/sparkify-rdb/src/insert/songplays.sql
 * Path: /run/media/kellermann/files/git_repo/sparkify-rdb/src/insert
 * Created Date: Saturday, July 10th 2021, 3:11:08 pm
 * Author: lkellermann
 * 
 * Copyright (c) 2021 CompanyName
 *
 * Insert statement for songplays fact table.
 ***************************************************************************/

INSERT INTO sparkify_app.songplays(
    start_time
	,user_id
	,level
	,song_id
	,artist_id
	,session_id
	,location
	,user_agent
)
VALUES(
	%s
	, %s
	, %s
	, %s
	, %s
	, %s
	, %s
	, %s
);