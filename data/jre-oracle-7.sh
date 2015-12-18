#!/usr/bin/env bash

INSTALL="apt-get install -y --force-yes --no-install-recommends"
UPDATE="apt-get update"
PACKAGES="oracle-java7-installer oracle-java7-set-default"

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main"> /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

eval "$UPDATE"
eval "$INSTALL $PACKAGES"

exit 0
