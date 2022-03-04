import glob
import json
import logging
import os
import sys
import time
from datetime import datetime
from urllib.request import HTTPError

from railib import api, config, show

engine_name = datetime.today().strftime('%Y-%m-%d')
database = 'chinook'

def create_chinook_db():
    # Configure logging
    logging.basicConfig(stream=sys.stderr,
                        format='%(asctime)s %(levelname)-8s %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S',
                        level=logging.DEBUG)

    # The Python API config.read() function takes the configuration file
    # and the profile name as optional arguments:
    cfg = config.read("~/.rai/config", profile="default")

    # Most API operations use a context object
    ctx = api.Context(**cfg)

    # Create a new engine with today's date
    size = api.EngineSize.XS
    logging.info("Provisioning engine: %s of size %s." % (engine_name, size))
    try:
        api.create_engine(ctx, engine_name, size)
        while api.get_engine(ctx, engine_name).get("state") != "PROVISIONED":
            logging.info("Waiting for provisioning...")
            time.sleep(10)
    except HTTPError as e:
        logging.warning(repr(e))
    logging.info("Provisioned engine: %s of size %s." % (engine_name, size))

    # Now let's create a database
    logging.info("Creating db: %s in engine %s." % (database, engine_name))
    try:
        api.create_database(ctx, database, engine_name, overwrite=True)
        while api.get_database(ctx, database).get("state") != "CREATED":
            logging.info("Waiting for database to be created...")
            time.sleep(10)
    except HTTPError as e:
        logging.warning(repr(e))
    logging.info("Created database: %s in engine %s." %
                 (database, engine_name))

    # To install models into the database, get an array of paths to model files
    # Then create dictionaries with keys as relative paths, without extensions
    paths = [os.path.abspath(f) for f in
             glob.iglob('./models/**/*.rel', recursive=True)]
    for path in paths:
        model_to_source = {}
        model = os.path.splitext(os.path.relpath(
            path, start='./models'))[0]
        model = model.replace('\\', '/')
        with open(path) as fp:
            model_to_source[model] = fp.read()
        logging.info("Installing model %s..." % model)
        api.install_model(ctx, database, engine_name, model_to_source)
    logging.info("Finished installing models.")

    # Install data
    filenames = ['album', 'artist', 'customer', 'employee', 'genre',
                 'invoice_line', 'invoice', 'media_type', 'playlist_track',
                 'playlist', 'track']
    for filename in filenames:
        datafile = 'data/chinook/' + filename + '.csv'
        queryfile = 'queries/chinook/rel/insert/' + filename + '.rel'
        with open(datafile, 'r', encoding="utf8") as file:
            data = file.read()
        with open(queryfile, 'r') as file:
            query = file.read()
        api.query(ctx, database, engine_name, query, inputs={"mydata": data},
                  readonly=False)
    logging.info("Finished installing data.")


def execute(queryfile):
    cfg = config.read("~/.rai/config", profile="default")
    ctx = api.Context(**cfg)
    with open(queryfile, 'r', encoding='utf-8') as file:
        query = file.read()
        response = api.query(ctx, database, engine_name, query)
        columns = response['output'][0]['columns']
        return(set(list(zip(*columns))))


if __name__ == '__main__':
    print(execute('queries/chinook/rel/5c.rel'))