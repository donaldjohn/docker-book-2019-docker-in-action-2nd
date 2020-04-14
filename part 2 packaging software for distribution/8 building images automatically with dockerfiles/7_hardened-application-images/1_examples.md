
# Content-addressable image identifiers

```shell script
docker pull debian:stable
```

# User permissions

```dockerfile
FROM busybox:latest
USER 1000:1000
RUN touch /bin/busybox
```

```dockerfile
FROM busybox:latest
USER 1000:1000
RUN touch /bin/busybox
```

```dockerfile
# add our user and group first to make sure their IDs get assigned
# consistently, regardless of whatever dependencies get added
RUN groupadd -r postgres && useradd -r -g postgres postgres
```

# SUID and SGID permissions

The last hardening action to cover is the mitigation of setuid (SUID) or setgid (SGID) permissions. The well-known filesystem permissions (read, write, execute) are only a portion of the set defined by Linux. In addition to those, two are of particular interest: SUID and SGID.

Each of the listed files in this particular image has the SUID or SGID permission, and a bug in any of them could be used to compromise the root account inside a con- tainer. 

Fix this problem and either delete all these files or unset their SUID and SGID per- missions. Taking either action would reduce the image’s attack surface. The following Dockerfile instruction will unset the SUID and GUID permissions on all files currently in the image:

```dockerfile
RUN for i in $(find / -type f \( -perm /u=s -o -perm /g=s \)); \
    do chmod ug-s $i; done
```
