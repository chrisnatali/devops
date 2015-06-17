#!/bin/bash
# script to enable ssh into a server as $RUN_USER via authorized keys
# 
# Adds RUN_USER and adds AUTHORIZED_KEYS for that user if vars are set

if [ ${RUN_USER} ]; then
    echo "=> Adding user $RUN_USER"
    useradd -s /bin/bash -m -G sudo $RUN_USER 
fi

# setup authorized keys for ssh access
if [ "${AUTHORIZED_KEYS}" ]; then
    echo "=> Adding authorized keys"
    mkdir -p /home/$RUN_USER/.ssh
    chmod 700 /home/$RUN_USER/.ssh
    touch /home/$RUN_USER/.ssh/authorized_keys
    chmod 600 /home/$RUN_USER/.ssh/authorized_keys
    chown -R $RUN_USER:$RUN_USER /home/$RUN_USER/.ssh
    IFS=$'\n'
    arr=$(echo ${AUTHORIZED_KEYS} | tr "," "\n")
    for x in $arr
    do
        x=$(echo $x | sed -e 's/^ *//' -e 's/ *$//')
        cat /home/$RUN_USER/.ssh/authorized_keys | grep "$x" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "=> Adding public key to .ssh/authorized_keys: $x"
            echo "$x" >> /home/$RUN_USER/.ssh/authorized_keys
        fi
    done
fi

# run ssh 
/usr/sbin/sshd -D
