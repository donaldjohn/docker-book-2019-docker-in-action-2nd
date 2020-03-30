# Building durable containers

Docker container can be in one of four states:
- Running
- Paused
- Restarting
- Exited (also used if the container has never been started)

# Automatically restarting containers

Docker provides this functionality with a restart policy. Using the --restart flag at
container-creation time, you can tell Docker to do any of the following:

- Never restart (default)
- Attempt to restart when a failure is detected
- Attempt for some predetermined time to restart when a failure is detected  Always restart the container regardless of the condition

A `backoff strategy` determines the amount of time that should pass between succes- sive restart attempts. 

# Using PID 1 and init systems

An init system is a program that's used to launch and maintain the state of other programs

In addition to other critical functions, an `init system` starts other processes, restarts them in the event that they fail, transforms and forwards signals sent by the operating system, and prevents resource leaks. It is common practice to use real init systems inside containers when that container will run multiple processes or if the program being run uses child processes.

Several such init systems could be used inside a container.

The most popular include `runit`, `Yelp/dumb-init`, `tini`, `supervisord`, and `tianon/gosu`.

# Startup scripts

Startup scripts are an important part of building durable containers and can always be combined with Docker restart policies to take advantage of the strengths of each.

Running startup scripts as PID 1 is problematic when the script fails to meet the expectations that Linux has for init systems.
