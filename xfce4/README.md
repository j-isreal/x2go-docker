# README for XFCE4 Desktop x2go Ubuntu Docker server

## Change the docker-compose-xfce4.yml file to use the appropriate image:

- jisreal/docker-x2go-xfce4-arm64
- jisreal/docker-x2go-xfce4-amd64

(or specify the image you built if you built one)

## Change the docker-compose-xfce4.yml file to use specific IP address:

- change the IP address after the ipv4_address:

 
## Use docker compose to get image and start container

Type the following from the command line:

```
docker compose -f docker-compose-xfce4.yml up -d
```
This starts the container and exits compose, leaving the container running in the background.
