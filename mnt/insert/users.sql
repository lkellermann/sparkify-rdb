/***************************************************************************
 * Filename: /run/media/kellermann/files/git_repo/sparkify-rdb/src/insert/users.sql
 * Path: /run/media/kellermann/files/git_repo/sparkify-rdb/src/insert
 * Created Date: Saturday, July 10th 2021, 3:17:25 pm
 * Author: lkellermann
 * 
 * Copyright (c) 2021 CompanyName
 *
 * Upsert statement for users dimension table.
 ***************************************************************************/


insert into sparkify_app.users(
    user_id
    ,first_name
    ,last_name
    ,gender
    ,level
)
VALUES(
    %s
    , %s
    , %s
    , %s
    , %s
)
	on conflict(user_id)
		do update
		set level = excluded.level /* An user can go from premium user to free user or from free user to premium user.*/