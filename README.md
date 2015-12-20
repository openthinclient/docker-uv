# docker-uv
This repository contains all sources necessary to build a openthinclient docker image frome the  ucs-appbox base image.

A stable version is not yet released.

## Installation Instruction

### Build the Image by hand (first way)
* clone this repo && checkout develop
* cd docker-uv 
* docker build -t openthinclient-uv .

### download from Docker hub (second way)

### launch a container
* xhost +
* bash run.sh install
** follow install Instructions
* bash run.sh --start

And you are done! 
* visit http://localhost:8080 to start the manager console

But...
there are some requirements to fullfill before managing and booting your devices with the openthinclient solution.
Further Information is provided here
* https://wiki.openthinclient.org/confluence/dashboard.action
* http://openthinclient.org/de/dokumentation-openthinclient/
