import glob
import logging
import os
import time
from urllib.request import HTTPError

from railib import api, config

logger = logging.getLogger(__name__)


class RaiConnector:
    def __init__(self):
        self.cfg = config.read('~/.rai/config', profile="default")
        self.engine_name = 'chinook_wh'
        self.database = 'chinook'

    def create_chinook_db(self):

        # Most API operations use a context object
        ctx = api.Context(**self.cfg)

        # Create a new engine
        size = api.EngineSize.XS
        logger.info("Provisioning engine: %s of size %s." %
                    (self.engine_name, size))
        try:
            api.create_engine(ctx, self.engine_name, size)
            while api.get_engine(ctx, self.engine_name).get("state") != "PROVISIONED":
                logger.info("Waiting for provisioning...")
                time.sleep(10)
        except HTTPError as e:
            if "HTTPError 409" in repr(e):
                logger.info("Engine already provisioned...")
            else:
                logger.warning(repr(e))

        # Now let's create a database
        logger.info("Creating db: %s in engine %s." %
                    (self.database, self.engine_name))
        try:
            api.create_database(ctx, self.database,
                                self.engine_name, overwrite=True)
            while api.get_database(ctx, self.database).get("state") != "CREATED":
                logger.info("Waiting for database to be created...")
                time.sleep(10)
        except HTTPError as e:
            logger.warning(repr(e))

        # To install models into the database, get an array of paths to model files
        # Then create dictionaries with keys as relative paths, without extensions
        logger.info("Installing models.")
        paths = [os.path.abspath(f) for f in
                 glob.iglob('./models/**/*.rel', recursive=True)]
        for path in paths:
            model_to_source = {}
            model = os.path.splitext(os.path.relpath(
                path, start='./models'))[0]
            model = model.replace('\\', '/')
            with open(path) as fp:
                model_to_source[model] = fp.read()
            logger.info("Installing model %s..." % model)
            api.install_model(ctx, self.database,
                              self.engine_name, model_to_source)


        # Install data
        logger.info("Installing data.")
        filenames = ['album', 'artist', 'customer', 'employee', 'genre',
                     'invoice_line', 'invoice', 'media_type', 'playlist_track',
                     'playlist', 'track']
        for filename in filenames:
            datafile = 'data/chinook/text/' + filename + '.csv'
            logger.info("Installing: %s" % datafile)
            queryfile = 'queries/chinook/rel/insert/' + filename + '.rel'
            with open(datafile, 'r', encoding="utf8") as file:
                data = file.read()
            with open(queryfile, 'r') as file:
                query = file.read()
            response = api.query(ctx, self.database, 
                                 self.engine_name, query, 
                                 inputs={"mydata": data},
                                 readonly=False)


    def execute(self, queryfile):
        ctx = api.Context(**self.cfg)
        with open(queryfile, 'r', encoding='utf-8') as file:
            query = file.read()
            response = api.query(ctx, self.database, self.engine_name, query)

            outputs = []
            arities = []
            # Response is a dictionary, we are interested in the 'output' key
            # which holds a list of dictionaries
            for i in response['output']:
                # Now we are iterating over a list of dictionaries, we are
                # interested in the key of 'columns' which holds a list of lists
                output = i['columns']

                # Let's create a list of tuples with this output and append it 
                # to out outputs list
                outputs.append(list(zip(*output)))

                # Let's also take a note of arities
                arities.append(len(output))
        
            # In most cases we have a single output, let's simply return it
            if len(outputs) == 1:
                return set(outputs[0])

            # But we may have multiple outputs too, let's merge them
            result = set()
            # Loop over the arities list
            for a in range(len(arities)):
                if arities[a] != max(arities):
                    # Fill in the missing elements with None
                    for t in outputs[a]:
                        l = list(t)
                        for _ in range(max(arities) - arities[a]):
                            l.append(None)
                        result.add(tuple(l))
                else:
                    # Add the tuples to result set
                    for t in outputs[a]:
                        result.add(t)

            return result


if __name__ == '__main__':
    rc = RaiConnector()
    print(rc.execute("queries/chinook/rel/8e.rel"))
