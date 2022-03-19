from duck import DuckDBConnector
from rai import RaiConnector
from snow import SnowflakeConnector
from sqlite import SQLiteConnector


def build():
    import sys
    import logging.config
    logging.basicConfig(stream=sys.stderr,
                        format='%(asctime)s %(levelname)-8s %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S',
                        level=logging.INFO)

    for v in logging.Logger.manager.loggerDict.values():
        
        if isinstance(v, logging.Logger):
            if v.name.startswith('snowflake'):
                v.disabled = True

    rc = RaiConnector()
    rc.create_chinook_db()

    snc = SnowflakeConnector()
    snc.create_chinook_db()

    dc = DuckDBConnector('data/chinook/duckdb/chinook.db')
    dc.create_chinook_db()

    sqc = SQLiteConnector('data/chinook/sqlite/chinook.db')
    sqc.create_chinook_db()


if __name__ == '__main__':
    build()
