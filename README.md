# x2go-docker README.md
<img src="https://img.shields.io/badge/version-1.0_alpha-blue" /> <img src="https://img.shields.io/badge/docker-version_24.0.7-green" /> <img src="https://img.shields.io/badge/ubuntu-latest_24.04-orange" />


==========

Docker compose scripts and docker hub images which contain different Ubuntu Desktop setups for x2go remote access

Currently we have

1. Ubuntu 24.04 (latest) with either:
   - LXDE desktop
   - XFCE4 desktop

## How to run on Docker ?
You can use a pre-built docker image or build for your system architecture/setup.

NOTE: It is highly recommended to use a pre-built Docker Hub image by just using the Docker compose method below.


Docker Hub images:

- [https://hub.docker.com/r/jisreal/docker-x2go-xfce4-arm64](https://hub.docker.com/r/jisreal/docker-x2go-xfce4-arm64)
- [https://hub.docker.com/r/jisreal/docker-x2go-lxde-arm64](https://hub.docker.com/r/jisreal/docker-x2go-lxde-arm64)
- [https://hub.docker.com/r/jisreal/docker-x2go-lxde-amd64](https://hub.docker.com/r/jisreal/docker-x2go-lxde-amd64)
- [https://hub.docker.com/r/jisreal/docker-x2go-xfce4-amd64](https://hub.docker.com/r/jisreal/docker-x2go-xfce4-amd64)


To build:

```
git clone https://github.com/j-isreal/x2go-docker.git
cd [lxde or xfce4]
docker build -t [yourimagename] .

** note down the root/dockerx passwords
```

### Create Container using Docker Compose
After you either build an image or choose to use a pre-built Docker Hub image, create your container using Docker Compose.

```
cd [lxde or xfce4]
docker compose -f docker-compose-lxde.yml

** note down the root/dockerx passwords
```


### How to run/connect to server with a Client?

Download the x2go client for your OS from:
[http://wiki.x2go.org/doku.php/doc:installation:x2goclient](http://wiki.x2go.org/doku.php/doc:installation:x2goclient)


#### Connect to your server with 

Host : (Your Server IP)

Port : 22

Username : dockerx 

Password : (varies or could be just 'changeme')


Select the Session TYPE as : XFCE or LXDE depending on your setup . 

You can also SSH to the docker container directly with root or dockerx users and their passwords over the port 22 with linux ssh or windows putty clients.

users dockerx can be used to login however for some reason you need to use root for your very first login then you can use dockerx to login with x2go :)

```
ssh root@dockerhost -p 22
```

## WHY ?

I wanted to expand on the original project and images that were created over a decade ago by [https://github.com/paimpozhil/](paimpozhil) to include the latest version of Ubuntu (including arm64 for my Raspberry Pi 4b) and the 2 lightweight desktops, XFCE4 and LXDE, via X2go.  Also created /home storage volume on host so it can be backed up from the docker host, updated network to use the local network for easy access, and created docker compose files for both desktop versions.

This system also works as a VERY cheap remote-desktop for anyone who wants a desktop on the cloud for anything from working remotely or browse internet where there are VPN restrictions.

Note you can run like 2-3 desktops over a cheap DigitalOcean/Linode like VPS.


## Need support?

#### http://dockerteam.com

### Credits:

####https://github.com/paimpozhil/DockerX2go
####http://bmullan.wordpress.com/
####https://github.com/rogaha/docker-desktop
####https://github.com/tutumcloud/tutum-ubuntu

#### Docker.io && x2go.org
