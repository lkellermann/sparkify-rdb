/***************************************************************************
 * Filename: /run/media/kellermann/files/git_repo/sparkify-rdb/src/select/song_select.sql
 * Path: /run/media/kellermann/files/git_repo/sparkify-rdb/src/select
 * Created Date: Saturday, July 10th 2021, 3:48:01 pm
 * Author: lkellermann
 * 
 * Copyright (c) 2021 CompanyName
 *
 * Get relation between song_id and artist_id by artist_id, artist_name, 
 * song title and song duration.
 ***************************************************************************/

select a.song_id
	, b.artist_id
from songs a 
join artists b on a.artist_id = b.artist_id
    where b.artist_name = %s 
		and a.title = %s
		and a.duration = %s;