The containers that Docker builds are isolated with respect to eight aspects. 

The specific aspects are as follows:

- PID namespace—Process identifiers and capabilities
- UTS namespace—Host and domain name
- MNT namespace—File system access and structure
- IPC namespace—Process communication over shared memory
- NET namespace—Network access and structure
- USR namespace—User names and identifiers
- chroot()—Controls the location of the file system root
- cgroups—Resource protection

- Detached container: the container will run in the background, without being attached to any input or output stream.
- Interactive container:
