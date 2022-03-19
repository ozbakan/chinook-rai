import configparser
import csv
import os
import logging
from pathlib import Path

import snowflake.connector

logger = logging.getLogger(__name__)

class SnowflakeConnector:
    def __init__(self):
        config = configparser.ConfigParser()
        config.read(os.path.join(str(Path.home()), '.snowflake/config'))
        self.cfg = config['default']

    def execute(self, sql_file):

        connection = snowflake.connector.connect(
            user=self.cfg['user'],
            password=self.cfg['password'],
            account=self.cfg['account']
        )
        cursor = connection.cursor()
        try:
            with open(sql_file, 'r', encoding='utf-8') as sql_file:
                content = sql_file.read()
            queries = content.split(";")
            for query in queries:
                query = query.rstrip()
                if not query.isspace():
                    cursor.execute('USE WAREHOUSE chinook_wh')
                    cursor.execute('USE DATABASE chinook')
                    cursor.execute('USE SCHEMA public')
                    cursor.execute(query)
                    return set(cursor.fetchall())

        finally:
            cursor.close()
            connection.close()

    def execute_script(self, sql_file):

        connection = snowflake.connector.connect(
            user=self.cfg['user'],
            password=self.cfg['password'],
            account=self.cfg['account']
        )
        cursor = connection.cursor()
        try:
            with open(sql_file, 'r', encoding='utf-8') as sql_file:
                content = sql_file.read()
            queries = content.split(";")
            for query in queries:
                query = query.rstrip()
                if not query.isspace():
                    cursor.execute(query)
                    one_row = cursor.fetchone()
                    if one_row is not None:
                        print(one_row[0])

        finally:
            cursor.close()
            connection.close()

    def get_version(self):
        # Gets the version
        connection = snowflake.connector.connect(
            user=self.cfg['user'],
            password=self.cfg['password'],
            account=self.cfg['account']
        )
        cursor = connection.cursor()
        try:
            cursor.execute("SELECT current_version()")
            one_row = cursor.fetchone()
            return(one_row[0])
        finally:
            cursor.close()
            connection.close()

    def create_chinook_db(self):
        logger.info("Creating chinook db in Snowflake...")
        self.execute_script('queries/chinook/sql/snowflake/create.sql')
        tables = ['album', 'artist', 'customer', 'employee', 'genre',
                  'invoice_line', 'invoice', 'media_type',
                  'playlist_track', 'playlist', 'track']
        for table in tables:
            self.insert(table, 'data/chinook/text')

    def insert(self, table, csv_directory):

        csv_file = csv_directory + '/' + table + '.csv'
        logger.info("Installing: %s" % csv_file)
        connection = snowflake.connector.connect(
            user=self.cfg['user'],
            password=self.cfg['password'],
            account=self.cfg['account']
        )
        cursor = connection.cursor()

        try:
            with open(csv_file, 'r', encoding='utf-8') as csv_file:
                reader = csv.DictReader(csv_file)
                cn = reader.fieldnames
                rows = [[r[c] for c in r] for r in reader]

            str_rows = ''
            row_counter = 0
            for row in rows:
                str_row = '('
                column_counter = 0
                for column in row:
                    v = column
                    if len(v) == 0:
                        v = 'null'
                    else:
                        v = ''.join([c * 2 if c == "'" else c for c in v])
                        v = ''.join([c * 2 if c == "\\" else c for c in v])
                        v = "'" + v + "'"
                    str_row += v
                    if column_counter != len(row) - 1:
                        str_row += ','
                    column_counter += 1
                str_row += ')'
                if row_counter != len(rows) - 1:
                    str_row += ','
                row_counter += 1
                str_rows += str_row

            cursor.execute('USE WAREHOUSE chinook_wh')
            cursor.execute('USE DATABASE chinook')
            cursor.execute('USE SCHEMA public')

            query = 'INSERT INTO ' + table \
                    + '(' + ', '.join(cn) + ') ' + \
                    'VALUES ' + str_rows

            cursor.execute(query)
            one_row = cursor.fetchone()
            if one_row is not None:
                print('Inserted %d rows to %s table.' % (one_row[0], table))
            connection.commit()

        except (Exception, snowflake.connector.Error) as error:
            print("Error while inserting data to Snowflake.", error)
        finally:
            if connection:
                cursor.close()
                connection.close()


if __name__ == '__main__':
    sc = SnowflakeConnector()
    sc.create_chinook_db()
