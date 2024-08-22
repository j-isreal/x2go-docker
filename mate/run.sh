#!/bin/bash
if [ ! -f /.root_pw_set ]; then
	/set_root_pw.sh
fi

#chmod 1777 /dev/shm

# might not need to start sshd here if enabled and started in image - will check
exec /usr/sbin/sshd -D
exec mate-session
