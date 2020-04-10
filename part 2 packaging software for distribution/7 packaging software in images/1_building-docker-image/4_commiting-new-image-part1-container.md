```shell script
#!/bin/bash
set -x # echo on

docker container rm -vf image-dev
docker container run -it --name image-dev ubuntu:latest /bin/bash

# manual install git into container
apt-get update
apt-get -y install git
git version
exit
```
