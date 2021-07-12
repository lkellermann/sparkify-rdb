/***************************************************************************
 * Filename: /run/media/kellermann/files/git_repo/sparkify-rdb/src/create/users.sql
 * Path: /run/media/kellermann/files/git_repo/sparkify-rdb/src/create
 * Created Date: Saturday, July 10th 2021, 3:08:51 pm
 * Author: lkellermann
 * 
 * Copyright (c) 2021 CompanyName
 *
 * Create statement for users dimension table.
 ***************************************************************************/

begin;
create table if not exists 
sparkify_app.users(
	user_id smallint primary key
	,first_name varchar not null
	,last_name varchar not null
	,gender varchar
	,level varchar
);
commit;