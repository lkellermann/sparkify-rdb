/***************************************************************************
 * Filename: /run/media/kellermann/files/git_repo/sparkify-rdb/src/create/time.sql
 * Path: /run/media/kellermann/files/git_repo/sparkify-rdb/src/create
 * Created Date: Saturday, July 10th 2021, 3:10:31 pm
 * Author: lkellermann
 * 
 * Copyright (c) 2021 CompanyName
 *
 * Create statement for time dimension table.
 ***************************************************************************/

begin;
create table if not exists 
sparkify_app.time(
	start_time date primary key
	,hour int
	,day int
	,week smallint
	,month smallint
	,year int
	,weekday smallint
);
commit;