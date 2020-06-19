# Example Deployment of the Cassandra PV Archiver

This folder contains an example deployment of
the Cassandra PV Archiver in a Docker network
with three containers:

* A Cassandra database
* The Cassandra PV Archiver
* An example IOC with some PVs to test archiving
  (`root:ai1`, `root:ai2`, ...).

Data and logs are stored in directories that are bind-mounted
from the host:

* `./storage/db/` is the datastore of the Cassandra db
* `./storage/logs/` contains the logfile of the Cassandra PV Archiver

Start the full stack defined in `docker-compose.yml` with:

```
docker-compose up
```

When the containers are started for the first time, the Cassandra
database is missing the keyspace for your samples.
Once your containers are up and running, execute the next statement
in another terminal to create the keyspace for the archiver:

```
CQL="CREATE KEYSPACE pv_archive WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};"
docker-compose exec cassandra cqlsh cassandra -e "${CQL}"
```

On <http://localhost:4812> you can then reach the administrative interface.
After logging in with the default `admin`/`admin` credentials, you can add
PVs to be archived (e.g. `root:ai1`).
The data can be retrieved via the port 9812, for example using
<http://localhost:9812/archive-access/api/1.0/archive/1/samples/root:ai1?start=1&end=2000000000000000000>

For the documentation, please consult the official manual found at
<https://oss.aquenos.com/cassandra-pv-archiver/>
