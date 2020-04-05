
Most modern Linux kernels enable seccomp, and Docker’s default seccomp profile blocks over 40 kernel system calls (syscalls) that most programs don’t need. You can enhance the containers Docker builds if you bring additional tools. Tools you can use to harden your containers include custom `seccomp profiles`, `AppArmor`, and `SELinux`.

Docker provides a single `--security-opt` flag for specifying options that configure Linux’s `seccomp` and Linux Security Modules (LSM) features. Security options can be provided to the `docker container run` and `docker container create` commands. This flag can be set multiple times to pass multiple values.

 If the default seccomp profile is too restrictive or permissive, a custom pro- file can be specified as a security option:
 
```shell script
docker container run --rm -it \
    --security-opt seccomp=<FULL_PATH_TO_PROFILE> \
    ubuntu:16.04 sh
```

`Linux Security Modules` is a framework Linux adopted to act as an interface layer between the operating system and security providers. `AppArmor` and `SELinux` are `LSM providers`. Both provide mandatory access control, or `MAC` (the system defines access rules), and replace the standard Linux discretionary access control (file owners define access rules).
