
# Linux user namespace and UID remappin

Linux’s user (USR) namespace maps users in one namespace to users in another.

By default, Docker containers do not use the USR namespace.

When a user namespace is enabled for a container,

For example, UID remapping could be configured to map container UIDs to the host starting with host UID 5000 and a range of 1000 UIDs. The result is that UID 0 in containers would be mapped to host UID 5000, container UID 1 to host UID 5001, and so on for 1000 UIDs. Since UID 5000 is an unprivileged user from Linux’ perspective and doesn’t have permissions to modify the host system files, the risk of running with uid=0 in the container is greatly reduced.
id dockremap