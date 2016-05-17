# Common Docker Utils/Images

This dir contains commonly used docker images and utilities

## Example

Run ssh server with 'mr' user and public ssh key

1.  Modify docker/docker-compose.yml to add

    `RUN_USER: 'mr'`
    `AUTHORIZED_KEYS: 'ssh-rsa....'`

    This will bring up an ssh server with user 'mr' added and ssh access via the authorized key

2.  Bring it up via:

    `docker-compose -p <name> up -d server`

3.  Get the ip via:

    ```
    for container in `docker ps -q`
      do docker inspect $container | python -c 'import json,sys;obj=json.load(sys.stdin);print(obj[0]["NetworkSettings"]["Networks"]["bridge"]["IPAddress"])'
    done
    ```
