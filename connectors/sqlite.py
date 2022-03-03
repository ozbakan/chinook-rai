import csv
import os
import sqlite3


class SQLiteConnector:
    def __init__(self, db_filepath):
        self.db_filepath = db_filepath

    def create_chinook_db(self):
        self.execute_script('queries/chinook/sql/sqlite/create.sql')
        tables = ['album', 'artist', 'customer', 'employee', 'genre',
                  'invoice_line', 'invoice', 'media_type',
                  'playlist_track', 'playlist', 'track']
        for table in tables:
            self.insert(table, 'data/chinook/text')

    def execute(self, sql_file):

        connection = None
        try:
            connection = sqlite3.connect(self.db_filepath)
            cursor = connection.cursor()
            with open(sql_file, 'r', encoding='utf-8') as sql_file:
                query = sql_file.read()
            cursor.execute(query)
            return set(cursor.fetchall())
        except (Exception, sqlite3.Error) as error:
            print("Error while fetching data from SQLite.", error)
        finally:
            if connection:
                cursor.close()
                connection.close()

    def execute_script(self, sql_file):

        connection = None
        try:
            connection = sqlite3.connect(self.db_filepath)
            cursor = connection.cursor()
            with open(sql_file, 'r', encoding='utf-8') as sql_file:
                query = sql_file.read()
            cursor.executescript(query)
            connection.commit()
        except (Exception, sqlite3.Error) as error:
            print("Error while fetching data from SQLite.", error)
        finally:
            if connection:
                cursor.close()
                connection.close()

    def insert(self, table, csv_directory):

        suffix = '.csv'
        csv_file = os.path.join(csv_directory, table + suffix)

        connection = None
        try:
            connection = sqlite3.connect(self.db_filepath)
            cursor = connection.cursor()
            with open(csv_file, 'r', encoding='utf-8') as csv_file:
                reader = csv.DictReader(csv_file)
                cn = reader.fieldnames
                tuples = [tuple([None if r[c] == '' else r[c] for c in r])
                          for r in reader]

            query = 'INSERT INTO ' + table + '(' + ', '.join(cn) + ') ' + \
                    'VALUES' + '(' + ', '.join('?' * len(cn)) + ');'
            cursor.executemany(query, tuples)
            print('Inserted %d rows to %s table.' % (len(tuples), table))
            connection.commit()
        except (Exception, sqlite3.Error) as error:
            print("Error while inserting data to SQLite.", error)
        finally:
            if connection:
                cursor.close()
                connection.close()


if __name__ == '__main__':
    sc = SQLiteConnector('data/chinook/sqlite/chinook.db')
    print(sc.execute('queries/chinook/sql/common/4a.sql'))
