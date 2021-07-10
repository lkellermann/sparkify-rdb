/***************************************************************************
 * Filename: /run/media/kellermann/files/git_repo/sparkify-rdb/src/create/songplay.sql
 * Path: /run/media/kellermann/files/git_repo/sparkify-rdb/src/create
 * Created Date: Saturday, July 10th 2021, 3:08:08 pm
 * Author: lkellermann
 * 
 * Copyright (c) 2021 CompanyName
 *
 * Create statement for fact table songplays (played songs by user).
 ***************************************************************************/


create table if not exists 
songplays(
    songplay_id serial primary key
    ,start_time date references time(start_time)
    ,user_id int not null references users(user_id) 
    ,level varchar 
    ,song_id varchar references songs(song_id) 
    ,artist_id varchar references artists(artist_id) 
    ,session_id int
    ,location varchar 
    ,user_agent varchar
);