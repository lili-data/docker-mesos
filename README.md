# Docker-Mesos

## Informations

* Based on Mesosphere mesos base image [mesosphere/mesos](https://hub.docker.com/r/mesosphere/mesos/)
* Install [Docker](https://www.docker.com/)
* The most important difference compared to the base image is Hadoop, Conda and Apache Spark already in the image. You can point Spark to the right directory on executors with spark.mesos.executor.home. For more info please visit https://spark.apache.org/docs/latest/running-on-mesos.html

## Build

The original concept is to build both the master and slave into the same container.

Please note requires a custom command to run the master or the slave.

If you want to add something else to the image after you can build with

    docker build liligo/mesos:TAG .

## Networking

Host networking (--net=host) is recommended. While Mesos can operate in bridge networking, it is slower and has many caveats and configuration complexities.

## Configuration

All configuration can be injected as environment variables.

Configuration reference: http://mesos.apache.org/documentation/latest/configuration/master-and-agent/

## How to run

Use-cases can differ but you can check how we use it [lilidata/dataplatform](https://hub.docker.com/r/lilidata/dataplatform/)

# License

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
