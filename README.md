# x2go-docker README.md
<a href="#"><img src="https://img.shields.io/badge/version-1.01.00-blue" /></a> <a href="#"><img src="https://img.shields.io/badge/docker-version_24.0.7-green" /></a> <a href="#"><img src="https://img.shields.io/badge/ubuntu-latest_24.04-orange" /></a>

<hr />

Docker compose scripts and docker hub images which contain different Ubuntu Desktop setups for x2go remote access desktop

To install docker, [https://docs.docker.com/engine/install/#server](https://docs.docker.com/engine/install/#server)

Currently, I have linux-based arm64 and amd64 images:

- Ubuntu 24.04 (latest) with either:
   - LXDE desktop
   - XFCE4 desktop
   - Mate desktop
  
## 1. Clone the git repo
Clone the git repo or [download the files](https://github.com/j-isreal/x2go-docker/archive/refs/heads/main.zip) so you can work with them.
```
git clone https://github.com/j-isreal/x2go-docker.git
```

## 2. Create docker network FIRST
Create a macvlan docker network for the local lan FIRST - see [1-create-network.md](https://github.com/j-isreal/x2go-docker/blob/998f9714272729bfac3506e83e5495dc16be2e9e/1-create-network.md)


### How to run on Docker ?
You can use my pre-built docker images or build one for your system architecture/setup using included Dockerfile.

NOTE: It is <u>highly recommended</u> to use a pre-built Docker Hub image [by using the Docker compose method below.
](https://github.com/j-isreal/x2go-docker/blob/main/README.md#3-create-container-using-docker-compose)
Docker Hub images - [use the docker compose method below](https://github.com/j-isreal/x2go-docker/blob/main/README.md#3-create-container-using-docker-compose):

- [https://hub.docker.com/r/jisreal/docker-x2go-xfce4-arm64](https://hub.docker.com/r/jisreal/docker-x2go-xfce4-arm64)
- [https://hub.docker.com/r/jisreal/docker-x2go-lxde-arm64](https://hub.docker.com/r/jisreal/docker-x2go-lxde-arm64)
- [https://hub.docker.com/r/jisreal/docker-x2go-mate-arm64](https://hub.docker.com/r/jisreal/docker-x2go-mate-arm64)
- [https://hub.docker.com/r/jisreal/docker-x2go-lxde-amd64](https://hub.docker.com/r/jisreal/docker-x2go-lxde-amd64)
- [https://hub.docker.com/r/jisreal/docker-x2go-xfce4-amd64](https://hub.docker.com/r/jisreal/docker-x2go-xfce4-amd64)


To build for your architecture/system - NOT SUGGESTED:

```
(go to folder you git cloned)
cd [lxde or xfce4 or mate]  # your choice of desktop
docker build -t [yourimagename] . # don't forget the trailing period
```

## 3. Create Container using Docker Compose
After you either choose to use a pre-built Docker Hub image or build an image, create your container using Docker Compose.

<b>Don't forget to edit the appropriate docker-compose file</b> to specify the correct image and IP address.  

See the README.md file in either the lxde or xfce4 folder first to make the changes.

```
(go to folder you git cloned)
cd [lxde or xfce4 or mate]  # your choice of desktop
docker compose -f docker-compose-lxde.yml up -d  # or -r docker-compose-xfce4.yml, your choice

** note down the root/dockerx passwords
```
The initial passwords will be displayed if you omit the -d above.  It's recommended to change the passwords immediately, for security.


## 4. Connect to x2go server with client

Download the x2go client for your OS from:
[http://wiki.x2go.org/doku.php/doc:installation:x2goclient](http://wiki.x2go.org/doku.php/doc:installation:x2goclient)

### Connect to your server with 

Host : (Your Server IP)

Port : 22

Username : dockerx 

Password : (varies or could be just 'changeme')


Select the Session TYPE as : XFCE or LXDE depending on your setup.

You can also SSH to the docker container directly with root or dockerx users and their passwords over the port 22 with linux ssh or windows putty clients.

User dockerx can be used to login; however, for some reason you need to use root for your very first login - then you can use dockerx to login with x2go :)

```
ssh root@dockerhost -p 22
```

## Persistent Disk Volume
The docker compose file sets up a disk storage volume called "x2go_homes" and is mounted inside the x2go server at "/home" - the user home folders location.

This volume will be located on the host machine at "/var/lib/docker/volumes/x2go_homes/_data" so you can make backups or perform file operations there.


## Why this project?

I wanted to expand on the original project and images that were created over a decade ago by [https://github.com/paimpozhil/](paimpozhil) to include the latest version of Ubuntu (including arm64 for my Raspberry Pi 4b) and the 2 lightweight desktops, XFCE4 and LXDE, via X2go.  Also created /home storage volume on host so it can be backed up from the docker host, updated network to use the local network for easy access, and created docker compose files for both desktop versions.

This system also works as a VERY cheap remote-desktop for anyone who wants a desktop on the cloud for anything from working remotely or browse internet where there are VPN restrictions.

You can run 2-3 desktops over a cheap DigitalOcean VPS.  I run this on my Raspberry Pi (which has 8GB RAM) and can get several users logged in at the same time.


## Need support?

#### http://dockerteam.com

### Credits:

- https://github.com/paimpozhil/DockerX2go
- http://bmullan.wordpress.com/
- https://github.com/rogaha/docker-desktop
- https://github.com/tutumcloud/tutum-ubuntu

- Docker.io and x2go.org

