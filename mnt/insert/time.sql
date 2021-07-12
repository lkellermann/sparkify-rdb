/***************************************************************************
 * Filename: /run/media/kellermann/files/git_repo/sparkify-rdb/src/insert/time.sql
 * Path: /run/media/kellermann/files/git_repo/sparkify-rdb/src/insert
 * Created Date: Saturday, July 10th 2021, 3:41:40 pm
 * Author: lkellermann
 * 
 * Copyright (c) 2021 CompanyName
 *
 * Upsert statement for time dimension table.
 ***************************************************************************/

insert into sparkify_app.time(
    start_time
    ,hour
    ,day
    ,week
    ,month
    ,year
    ,weekday
)
values(
    %s
    , %s
    , %s
    , %s
    , %s
    , %s
    , %s
)
	on conflict(start_time) /* The dimension table is created based on songplays. Two or more users can start*/
    do nothing;             /* any music at the same time that this will not break this statement. */