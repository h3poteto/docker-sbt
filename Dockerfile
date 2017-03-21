FROM openjdk:8

ENV SCALA_VERSION 2.12.1
ENV SBT_VERSION 0.13.13


WORKDIR /tmp

# Install Scala
RUN set -x && \
  mkdir -p /usr/local/scala && \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /usr/local/scala && \
  rm -rf /tmp/* && \
  touch $JAVA_HOME/release
ENV PATH $PATH:/usr/local/scala/scala-$SCALA_VERSION/bin

RUN useradd -m -s /bin/bash scala

# Install sbt
RUN set -x && \
  curl -L -o sbt-${SBT_VERSION}.deb http://dl.bintray.com/sbt/debian/sbt-${SBT_VERSION}.deb && \
  dpkg -i sbt-${SBT_VERSION}.deb && \
  rm sbt-${SBT_VERSION}.deb && \
  apt-get update && \
  apt-get install sbt && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/opt/app && \
  chown -R scala:scala /var/opt/app

USER scala

WORKDIR /var/opt/app
