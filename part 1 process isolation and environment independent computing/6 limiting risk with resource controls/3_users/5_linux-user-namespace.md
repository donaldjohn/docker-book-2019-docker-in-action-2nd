
- https://docs.docker.com/engine/security/userns-remap/

* The (default) dockremap user for remapping container UID and GID ranges
*  An entry in /etc/subuid of dockremap:5000:10000, providing a range of 10,000 UIDs starting at 5000
*  An entry in /etc/subgid of dockremap:5000:10000, providing a range of 10,000 GIDs starting at 5000

```shell script
# id dockremap
uid=997(dockremap) gid=993(dockremap) groups=993(dockremap)
# cat /etc/subuid
dockremap:5000:10000
# cat /etc/subgid
dockremap:5000:10000
# mkdir /tmp/shared
# chown -R 5000:5000 /tmp/shared
```

```shell script
# docker run -it --rm --user root -v /tmp/shared:/shared -v /:/host alpine ash
  Changes ownership of "shared" directory to UID used for remapped container UID 0
 / # touch /host/afile
touch: /host/afile: Permission denied
/ # echo "hello from $(id) in $(hostname)" >> /shared/afile
/ # exit
# back in the host shell
# ls -la /tmp/shared/afile
-rw-r--r--. 1 5000 5000 157 Apr 16 00:13 /tmp/shared/afile

# cat /tmp/shared/afile
# /tmp/shared is owned by host’s nonprivileged UID and GID: 5000:5000, so write allowed
hello from uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),
3(sys),4(adm),6(disk),10(wheel),11(floppy),20(dialout),26(tape), 27(video) in d3b497ac0d34
```

