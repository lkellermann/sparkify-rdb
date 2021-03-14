# DROP TABLES

songplay_table_drop = "drop table if exists songplays cascade;"
user_table_drop = "drop table if exists users cascade;"
song_table_drop = "drop table if exists songs cascade;"
artist_table_drop = "drop table if exists artists cascade;"
time_table_drop = "drop table if exists time cascade;"

# CREATE TABLES

songplay_table_create = ("""create table if not exists songplays (songplay_id serial primary key
										,start_time date references time(start_time)
    									,user_id int not null references users(user_id) 
    									,level varchar 
    									,song_id varchar references songs(song_id) 
    									,artist_id varchar references artists(artist_id) 
    									,session_id int
    									,location varchar 
    									,user_agent varchar);""")

user_table_create = ("""create table if not exists users(user_id smallint primary key
								,first_name varchar not null
								,last_name varchar not null
								,gender varchar
								,level varchar);""")

song_table_create = ("""create table if not exists songs( song_id varchar primary key
								,title varchar not null
								,artist_id varchar not null  
								,year int
								,duration float not null);""")

artist_table_create = ("""create table if not exists artists (artist_id varchar primary key
									,artist_name text not null
									,artist_location text
									,artist_latitude float
									,artist_longitude float);""")

time_table_create = ("""create table if not exists time(start_time date primary key
								,hour int
								,day int
								,week smallint
								,month smallint
								,year int
								,weekday smallint);""")


# INSERT RECORDS
songplay_table_insert = ("""INSERT INTO songplays(start_time
												,user_id
												,level
												,song_id
												,artist_id
												,session_id
												,location
												,user_agent)
							VALUES (%s, %s, %s, %s, %s, %s, %s, %s);""")

user_table_insert = ("""INSERT INTO users(user_id,
                                          first_name,
                                          last_name,
                                          gender,
                                          level)
							VALUES(%s, %s, %s, %s, %s)
							ON CONFLICT (user_id)
								DO UPDATE
									SET level = excluded.level""")


song_table_insert = ("""INSERT INTO songs(song_id
										  ,title
										  ,artist_id
										  ,year
										  ,duration)
							VALUES(%s, %s, %s, %s, %s)
							ON CONFLICT (song_id) DO NOTHING;""")


artist_table_insert = ("""INSERT INTO artists(artist_id,
											  artist_name,
											  artist_location,
											  artist_latitude
											  ,artist_longitude)
							VALUES(%s, %s, %s, %s, %s)
							ON CONFLICT (artist_id) DO NOTHING;""")


time_table_insert = ("""INSERT INTO time(start_time,
                                        hour,
                                        day,
                                        week,
                                        month,
                                        year,
                                        weekday)
								VALUES(%s, %s, %s, %s, %s, %s, %s)
								ON CONFLICT (start_time) DO NOTHING;""")

# FIND SONGS
# Composed key: artist_name+title+duration
song_select = ("""select a.song_id
				, b.artist_id
				FROM songs a JOIN artists b ON a.artist_id = b.artist_id
				where b.artist_name = %s 
					 and a.title = %s
					and a.duration = %s;""")

# QUERY LISTS
create_table_queries = [songplay_table_create, user_table_create,
                        song_table_create, artist_table_create, time_table_create][::-1]
drop_table_queries = [songplay_table_drop, user_table_drop,
                      song_table_drop, artist_table_drop, time_table_drop]
