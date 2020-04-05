#!/bin/bash
set -x # echo on

# MacOS has some mounting problems because of the differences in user and group owning the file versus user and group modifying/reading the file. As a workaround,
# - https://stackoverflow.com/questions/36068456/how-to-handle-permission-inside-a-volume-from-docker

# Cannot verify in MacOS as it is not running Docker natively

# Creates new file on your host
garbage="/tmp/garbage"
echo "e=mc^2" > "${garbage}"

cat "${garbage}"
ls -l "${garbage}"

# Makes file readable only by its owner
chmod 600 "${garbage}"

# Makes file owned by root (assuming you have sudo access)
sudo chown root "${garbage}"

# Tries to read file as nobody
docker container run --rm -v "${garbage}":/test/garbage \
  -u nobody \
  ubuntu:16.04 cat /test/garbage
# cat: /test/garbage: Permission denied

# Tries to read file as “container root”
docker container run --rm -v "${garbage}":/test/garbage \
  -u root ubuntu:16.04 cat /test/garbage
# Outputs: "e=mc^2"

# cleanup that garbage
sudo rm -f "${garbage}"
