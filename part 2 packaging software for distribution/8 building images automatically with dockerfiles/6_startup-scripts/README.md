
# Environmental preconditions validation

Validating the preconditions for a program startup is generally use-case specific.

- Presumed links (and aliases)
- Environment variables
- Secrets
- Network access
- Network port availability
- Root filesystem mount parameters (read-write or read-only)- Volumes
- Current user

# Initialization processes

Popular options include runit, tini, BusyBox init, Supervisord, and DAEMON Tools.

- Additional dependencies the program brings into the image
- File sizes
- How the program passes signals to its child processes (or if it does at all)
- Required user access
- Monitoring and restart functionality (backoff-on-restart features are a bonus)
- Zombie process cleanup features
