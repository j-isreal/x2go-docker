#!/bin/bash

if [ -f /.root_pw_set ]; then
	echo "Root password already set!  dockerx user exists."
	exit 0
fi

PASS=${ROOT_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${ROOT_PASS} ] && echo "preset" || echo "random" )
echo "=> Setting a ${_word} password to the root user"
echo "root:$PASS" | chpasswd

adduser --disabled-password --gecos "" dockerx 
adduser dockerx sudo

DPASS=$(pwgen -s 12 1)

echo "=> Setting a password to the docker user"
echo "dockerx:$DPASS" | chpasswd

echo "=> Setting dockerx users group to x2go user"
adduser dockerx x2gouser

echo "=> Done!"
touch /.root_pw_set

IP=$(hostname -I)
echo "========================================================================"
echo "You can now connect to this Ubuntu container via SSH using:"
echo " "
echo "    ssh -p 22 root@$IP"
echo "and enter the root password '$PASS' when prompted"
echo " "
echo " dockerx password : $DPASS "
echo "use this to connect to the x2go server from your x2go client!"
echo "Please remember to change the above passwords as soon as possible!"
echo "========================================================================"
echo " "
