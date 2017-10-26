FROM mesosphere/mesos:1.3.0

ENV DEBIAN_FRONTEND noninteractive

RUN  apt-get update && apt-get install -yqq --no-install-recommends \
        docker.io \
        wget \
        nano \
        curl \
        unzip \
        gfortran \
        curl \
        software-properties-common \
        python-software-properties \
        libopenblas-dev \
        liblapack-dev  \
        build-essential

RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get -y update
RUN /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java8-installer oracle-java8-set-default

# Configure environment
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN cd /tmp && \
    mkdir -p $CONDA_DIR && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda-latest-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda-latest-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda install --yes conda

WORKDIR /tmp


RUN conda install \
        'pandas=0.17*' \
        'scipy=0.16*' \
        'numpy' \
        'scikit-learn=0.16*' \
        statsmodels \
        pyzmq \
        && conda clean -yt

ENV HADOOP_VERSION 2.7.4
RUN \
      curl -s http://www.eu.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz  | tar -xz -C /usr/local/ && \
      ln -s /usr/local/hadoop-${HADOOP_VERSION} /usr/local/hadoop && \
      rm -f /tmp/hadoop-${HADOOP_VERSION}.tar.gz

ENV SPARK_VERSION 1.6.1
RUN \
        curl -s http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop2.6.tgz  | tar -xz -C /usr/local/ && \
        rm -f /tmp/spark-${SPARK_VERSION}-bin-hadoop2.6.tgz


ENV SPARK_VERSION 2.0.0
RUN \
        curl -s http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz  | tar -xz -C /usr/local/ && \
        rm -f /tmp/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz

ENV SPARK_VERSION 2.0.1
RUN \
        curl -s http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz  | tar -xz -C /usr/local/ && \
        rm -f /tmp/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz

ENV SPARK_VERSION 2.1.0
RUN \
        curl -s http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz  | tar -xz -C /usr/local/ && \
        rm -f /tmp/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz

ENV SPARK_VERSION 2.2.0
RUN \
        curl -s http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz  | tar -xz -C /usr/local/ && \
        rm -f /tmp/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV HADOOP_HOME /usr/local/hadoop



RUN echo 'docker,mesos' > /etc/mesos-slave/containerizers
##Increase the executor timeout to account for the potential delay in pulling a docker image to the slave.
RUN echo '5mins' > /etc/mesos-slave/executor_registration_timeout
RUN echo Europe/Paris > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
