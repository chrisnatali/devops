# DevOps Utiltities

These are simple scripts that can be run without a lot of extra insfrastructure (i.e. Chef or Puppet)

Top level dir contains more generic utilities.

Lower level dirs contain utils for more specific purposes.

## Examples

Setup server with authorized_key access only and add 'mr' user with 
authorized_key access and sudo group membership:
```
# assumes 172.17.0.8 is server to be setup
# and that root has authorized_key access
ssh root@172.17.0.8 bash -s < bootstrap.sh
ssh root@172.17.0.8 RUN_USER="mr" AUTHORIZED_KEYS=\"$(cat ~/.ssh/id_rsa.pub)\" bash -s < add_user.sh
```

Setup docker instance with root authorized_key access:
```
docker run -d --name setup_test cjon/sshd:0.1 /bin/bash -c "mkdir -p /root/.ssh; echo `cat ~/.ssh/id_rsa.pub` > /root/.ssh/authorized_keys; chmod 600 /root/.ssh/authorized_keys; /usr/sbin/sshd -D"
```
