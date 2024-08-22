# Create Docker Network
First, you need to create a network to use with the docker images in this project.

The command below will create a macvlan for docker to use the local lan and sets the parent ethernet card.

<b>You must do this BEFORE spinning up the container.</b>

 
<b>IMPORTANT:</b> Make the following changes to the command below:

- Replace the name of your network card below after "parent=" (change from eth0 to enps01 or whatever your ethernet is)
- Change the subnet and gateway to your home or office LAN settings (get from router or "ip a")

## Run from command line (with changes from above)
```
docker network create -d macvlan \
  --subnet=192.168.0.0/24 \
  --gateway=192.168.0.1 \
  -o parent=eth0 macvlan10
```


