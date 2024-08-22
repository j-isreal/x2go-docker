# Create Docker Network
First, you need to create a network to use with the docker images in this project.

This will create a macvlan for docker to use the local lan and sets the parent ethernet card.

IMPORTANT: Replace the name of your network card below (change from eth0 to enps01 or whatever your ethernet is)


```
docker network create -d macvlan \
  --subnet=192.168.0.0/24 \
  --gateway=192.168.0.1 \
  -o parent=eth0 macvlan10
```


