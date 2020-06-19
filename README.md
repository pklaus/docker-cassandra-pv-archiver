# Docker Image for Cassandra PV Archiver

The [Cassandra PV Archiver][] is a product of aquenos GmbH and
licensed under the term of the [Eclipse Public License v1.0][].

This repository is an effort to package the archiver for
use in a containerized EPICS architecture.

### Example Deployment

The subfolder [example-deployment](./example-deployment) contains
a docker-compose environment to run a single instance of the
archiver together with a single instance of a Cassandra database
and an example IOC inside a Docker network.
The management and data retrieval ports (4812, 9812) of the archiver are
forwarded to the respective host ports to allow interaction with
the archiver on the host machine.

[Eclipse Public License v1.0]: http://www.eclipse.org/legal/epl-v10.html
[Cassandra PV Archiver]: https://oss.aquenos.com/cassandra-pv-archiver/
