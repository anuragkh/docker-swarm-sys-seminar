# Docker Swarm Demo

This repository contains all the instructions and materials required to run the
demo for Docker Swarm. The demo is designed to run on your local MacBook Pro.
Some script tweaking might be required to make this run on other platforms.

## Installing Docker for Mac

Follow the instructions provided 
[here](https://docs.docker.com/docker-for-mac/) to install all 
required Docker Components.

Run

```bash
docker ps
```

on a shell to make sure the installation was successful.

## Install VirtualBox

Download and install the latest version of VirtualBox from
[here](https://www.virtualbox.org/wiki/Downloads).

## Setup a Docker Swarm

The script at [setup-swarm.sh](setup-swarm.sh) should setup a Docker Swarm for
you; it follows the instructions provided 
[here](https://docs.docker.com/swarm/install-w-machine/) to setup a sandbox
environment for trying out Docker Swarm.

**Note: This script will take some time to run, and requires internet 
connectivity since it downloads a (~38MB) VM image and creates three VMs from
the image.**

Once the setup is complete, you can check if the docker machines are running:

```bash
$ docker-machine ls
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
agent1    -        virtualbox   Running   tcp://192.168.99.101:2376           v1.12.0-rc2
agent2    -        virtualbox   Running   tcp://192.168.99.102:2376           v1.12.0-rc2
manager   -        virtualbox   Running   tcp://192.168.99.100:2376           v1.12.0-rc2
```

you can also run a simple dummy container with the 
[swarm-helloworld.sh](swarm-helloworld.sh) script. This should do the following:

1. Print information about your swarm:

```
Containers: 2
 Running: 2
 Paused: 0
 Stopped: 0
Images: 2
Server Version: swarm/1.2.3
Role: primary
Strategy: spread
Filters: health, port, containerslots, dependency, affinity, constraint
Nodes: 2
 agent1: 192.168.99.101:2376
  └ ID: G4UC:OY7T:TOMG:D5BN:6RS6:IFMX:FLAM:WYYA:UNSG:KKJG:36CO:CRBG
  └ Status: Healthy
  └ Containers: 1
  └ Reserved CPUs: 0 / 1
  └ Reserved Memory: 0 B / 1.021 GiB
  └ Labels: executiondriver=, kernelversion=4.4.13-boot2docker, operatingsystem=Boot2Docker 1.12.0-rc2 (TCL 7.1); HEAD : 52952ef - Fri Jun 17 21:01:09 UTC 2016, provider=virtualbox, storagedriver=aufs
  └ UpdatedAt: 2016-06-20T21:11:27Z
  └ ServerVersion: 1.12.0-rc2
 agent2: 192.168.99.102:2376
  └ ID: VUVC:4IOJ:LXZG:DO7I:XFHS:V37H:CGHX:VOJZ:XNBW:H26T:KKU2:XQDH
  └ Status: Healthy
  └ Containers: 1
  └ Reserved CPUs: 0 / 1
  └ Reserved Memory: 0 B / 1.021 GiB
  └ Labels: executiondriver=, kernelversion=4.4.13-boot2docker, operatingsystem=Boot2Docker 1.12.0-rc2 (TCL 7.1); HEAD : 52952ef - Fri Jun 17 21:01:09 UTC 2016, provider=virtualbox, storagedriver=aufs
  └ UpdatedAt: 2016-06-20T21:11:24Z
  └ ServerVersion: 1.12.0-rc2
Plugins:
 Volume:
 Network:
Swarm:
 NodeID:
 IsManager: No
Security Options:
Kernel Version: 4.4.13-boot2docker
Operating System: linux
Architecture: amd64
CPUs: 2
Total Memory: 2.042 GiB
Name: a816a928d365
Docker Root Dir:
Debug Mode (client): false
Debug Mode (server): false
WARNING: No kernel memory limit support
```

2. Run a dummy "hello world" container on your swarm:

```
Hello from Docker.
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker Hub account:
 https://hub.docker.com

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/
```

3. List out which container the "hello world" container ran on:

```
CONTAINER ID        IMAGE               COMMAND                  CREATED                  STATUS                              PORTS               NAMES
a1210cea4120        hello-world         "/hello"                 Less than a second ago   Exited (0) Less than a second ago                       agent1/nostalgic_darwin
f94f855affd4        swarm               "/swarm join --addr=1"   8 minutes ago            Up 8 minutes                        2375/tcp            agent2/boring_northcutt
348e7a0a17a4        swarm               "/swarm join --addr=1"   8 minutes ago            Up 8 minutes                        2375/tcp            agent1/cranky_keller
```

## Running the Demo


