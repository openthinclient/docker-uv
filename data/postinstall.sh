#!/bin/bash

## If allready installed, drop in shell and exit ##
if [ -f /tmp/installed ]; then
    /bin/bash
    exit 0
fi
     
## Installation on first container launch ##
java -jar /tmp/data/openthinclient-2.1-Pales.jar 

## Abort if Installation failed ##
[ $? -ne 0 ] && \
    echo -e "ERROR: Installation failed. Retry" && \
    exit 1

## Abort if start.sh script is missing ##
if [ ! -f /tmp/data/start.sh ]; then
    echo -e "ERROR: Configuration files are missing"
    exit 1
fi
    
## Replace start.sh and exit ##
cp /tmp/data/start.sh /opt/openthinclient/bin/start.sh 

[ $? -ne 0 ] && \
    echo -e "ERROR: Replacing start.sh failed. Retry" && \
    exit 1

## Restart the service and mark as installed ##
sh /opt/openthinclient/bin/start.sh restart && \
    echo -e "OK: Postinstall succeeds" && \
    touch /tmp/installed && \
    exit 0
