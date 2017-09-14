FROM openjdk:8

ENV SBT_VERSION 0.13.16


WORKDIR /tmp

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
