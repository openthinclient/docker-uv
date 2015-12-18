# openthinclient-suite inside Docker FROM debian
FROM univention/ucs-appbox-amd64:4.0-0
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    oracle-java8-installer \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


COPY data/jre-oracle-7.sh /tmp/
COPY data/openthinclient-installer.sh /tmp/
COPY data/openthinclient-2.0-consus.jar /tmp/
COPY data/start.sh /tmp/

RUN useradd -ms /bin/bash vagrant

# install Software from local source
RUN sh /tmp/jre-oracle-7.sh
RUN sh /tmp/openthinclient-installer.sh
RUN cp /tmp/start.sh /opt/openthinclient/bin/./start.sh
# RUN /etc/init.d/openthinclient restart
RUN /opt/openthinclient/bin/start.sh start

# Clean up a little
RUN rm -f /tmp/*.jar
RUN rm -f /tmp/*.sh

