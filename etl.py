import os
import glob
import psycopg2
import pandas as pd
from sql_queries import *


def process_song_file(cur: object, filepath: str) -> None:
    """Method to process song files.

    Args:
        cur (object): psycopg cursor.
        filepath (str): path to song files.

    Returns:
        None: Reads song data and creates songs and artists dimension tables on sparkifydb.
    """

    # open song file
    df = pd.read_json(filepath, lines=True)

    # insert song record
    song_data = df[['song_id',
                    'title',
                    'artist_id',
                    'year',
                    'duration']].values[0]
    cur.execute(song_table_insert, song_data)

    # insert artist record
    artist_data = df[['artist_id',
                      'artist_name',
                      'artist_location',
                      'artist_longitude',
                      'artist_latitude']].values[0]

    cur.execute(artist_table_insert, artist_data)
    return None


def process_log_file(cur: object, filepath: str) -> None:
    """Method to process log files.

    Args:
        cur (object): psycopg2 cursor object.
        filepath (str): path to log files.

    Returns:
        None: get customer events on sparkify and generates time dimension table.
    """

    # open log file
    df = pd.read_json(filepath, lines=True)

    # filter by NextSong action
    df = df[df.page == 'NextSong']

    # Generates time_df
    time_df = pd.DataFrame(df['ts'])

    # Convert ts to datetime:
    time_df['start_time'] = pd.to_datetime(df['ts'], unit='ms')
    time_df['hour'] = time_df.start_time.dt.hour
    time_df['day'] = time_df.start_time.dt.day

    # Day of the week.
    time_df['week'] = time_df.start_time.dt.strftime('%V').astype(int)
    time_df['month'] = time_df.start_time.dt.month
    time_df['year'] = time_df.start_time.dt.year
    time_df['week_day'] = time_df.start_time.dt.weekday

    for i, row in time_df.iterrows():
        cur.execute(time_table_insert, list(row))

    # load user table
    user_df = df[['userId', 'firstName', 'lastName', 'gender', 'level']]

    # insert user records
    for i, row in user_df.iterrows():
        cur.execute(user_table_insert, row)

    # insert songplay records
    for index, row in df.iterrows():

        # get songid and artistid from song and artist tables
        cur.execute(song_select, (row.song, row.artist, row.length))
        results = cur.fetchone()

        if results:
            songid, artistid = results
        else:
            songid, artistid = None, None

        # insert songplay record
        songplay_data = (index,
                         pd.to_datetime(row.ts, unit='ms'),
                         int(row.userId),
                         row.level,
                         songid,
                         artistid,
                         row.sessionId,
                         row.location,
                         row.userAgent,)
        cur.execute(songplay_table_insert, songplay_data)
    return None


def process_data(cur: object, conn: object, filepath: str, func: object) -> None:
    """Walks through all files under filepath and process them.

     Args:
         cur (object): psycopg2 cursor object.
         conn (object): psycopg2 connection object.
         filepath (str): data filepath
         func (object): function to execute over the files.

     Returns:
         None: look for files, process them and load into sparkifydb.
     """
    # get all files matching extension from directory
    all_files = []
    for root, dirs, files in os.walk(filepath):
        files = glob.glob(os.path.join(root, '*.json'))

        for f in files:
            all_files.append(os.path.abspath(f))

    # get total number of files found
    num_files = len(all_files)
    print('{} files found in {}'.format(num_files, filepath))

    # iterate over files and process
    for i, datafile in enumerate(all_files, 1):
        func(cur, datafile)
        conn.commit()
        print('{}/{} files processed.'.format(i, num_files))
    return None


def main():
    conn = psycopg2.connect(
        "host=127.0.0.1 dbname=sparkifydb user=student password=student")
    cur = conn.cursor()

    process_data(cur, conn, filepath='data/song_data', func=process_song_file)
    process_data(cur, conn, filepath='data/log_data', func=process_log_file)

    conn.close()


if __name__ == "__main__":
    main()
