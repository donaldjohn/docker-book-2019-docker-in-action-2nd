#!/bin/bash
set -x # echo on

# Enables the service abstraction
docker swarm init

# Unlike containers, Docker services are available only when Docker is running in swarm mode
docker service create \
  --publish 8080:80 \
  --name hello-world \
  dockerinaction/ch11_service_hw:v1

# http://localhost:8080

# Automated resurrection and replication
CONTAINER_ID=$(docker ps | grep 'dockerinaction/ch11_service_hw:v1' | cut -d' ' -f1)
docker container rm -f "${CONTAINER_ID}"
# wait about 3~5 seconds, the container start again
docker ps

docker service scale hello-world=3
# hello-world scaled to 3
# overall progress: 1 out of 3 tasks
# 1/3: starting  [============================================>      ]
# 2/3: running   [==================================================>]
# 3/3: starting  [============================================>      ]
# verify: Service converged

docker container ps

docker service ls
# ID                  NAME                MODE                REPLICAS            IMAGE                               PORTS
# czwcly90xzas        hello-world         replicated          1/1                 dockerinaction/ch11_service_hw:v1   *:8080->80/tcp

docker service ps hello-world
# ID                  NAME                IMAGE                               NODE                DESIRED STATE       CURRENT STATE            ERROR                         PORTS
# m7h2aqp9b0ae        hello-world.1       dockerinaction/ch11_service_hw:v1   docker-desktop      Running             Running 2 minutes ago
# ziaq5sxioqkt         \_ hello-world.1   dockerinaction/ch11_service_hw:v1   docker-desktop      Shutdown            Shutdown 2 minutes ago
# ocdk5x65oncf         \_ hello-world.1   dockerinaction/ch11_service_hw:v1   docker-desktop      Shutdown            Failed 12 hours ago      "task: non-zero exit (137)"

docker service inspect hello-world
#[
#    {
#        "ID": "czwcly90xzas2p7jr4ul9p05j",
#        "Version": {
#            "Index": 13
#        },
#        "CreatedAt": "2020-04-15T01:15:06.4210145Z",
#        "UpdatedAt": "2020-04-15T01:15:06.4299031Z",
#        "Spec": {
#            "Name": "hello-world",
#            "Labels": {},
#            "TaskTemplate": {
#                "ContainerSpec": {
#                    "Image": "dockerinaction/ch11_service_hw:v1@sha256:4f92ec42207773b4ea97afe03469ff30598d08dd2ec4a28e05550b3ba4bc5fd5",
#                    "Init": false,
#                    "StopGracePeriod": 10000000000,
#                    "DNSConfig": {},
#                    "Isolation": "default"
#                },
#                "Resources": {
#                    "Limits": {},
#                    "Reservations": {}
#                },
#                "RestartPolicy": {
#                    "Condition": "any",
#                    "Delay": 5000000000,
#                    "MaxAttempts": 0
#                },
#                "Placement": {
#                    "Platforms": [
#                        {
#                            "Architecture": "amd64",
#                            "OS": "linux"
#                        }
#                    ]
#                },
#                "ForceUpdate": 0,
#                "Runtime": "container"
#            },
#            "Mode": {
#                "Replicated": {
#                    "Replicas": 1
#                }
#            },
#            "UpdateConfig": {
#                "Parallelism": 1,
#                "FailureAction": "pause",
#                "Monitor": 5000000000,
#                "MaxFailureRatio": 0,
#                "Order": "stop-first"
#            },
#            "RollbackConfig": {
#                "Parallelism": 1,
#                "FailureAction": "pause",
#                "Monitor": 5000000000,
#                "MaxFailureRatio": 0,
#                "Order": "stop-first"
#            },
#            "EndpointSpec": {
#                "Mode": "vip",
#                "Ports": [
#                    {
#                        "Protocol": "tcp",
#                        "TargetPort": 80,
#                        "PublishedPort": 8080,
#                        "PublishMode": "ingress"
#                    }
#                ]
#            }
#        },
#        "Endpoint": {
#            "Spec": {
#                "Mode": "vip",
#                "Ports": [
#                    {
#                        "Protocol": "tcp",
#                        "TargetPort": 80,
#                        "PublishedPort": 8080,
#                        "PublishMode": "ingress"
#                    }
#                ]
#            },
#            "Ports": [
#                {
#                    "Protocol": "tcp",
#                    "TargetPort": 80,
#                    "PublishedPort": 8080,
#                    "PublishMode": "ingress"
#                }
#            ],
#            "VirtualIPs": [
#                {
#                    "NetworkID": "r7h3xeh89o9r4d19143huq36c",
#                    "Addr": "10.0.0.3/24"
#                }
#            ]
#        }
#    }
#]

# Automated rollout
# v2: the new image
# hello-world: the name of the service to update
docker service update \
  --image dockerinaction/ch11_service_hw:v2 \
  --update-order stop-first \
  --update-parallelism 1 \
  --update-delay 30s \
  hello-world
# hello-world
# overall progress: 3 out of 3 tasks
# 1/3: running   [==================================================>]
# 2/3: running   [==================================================>]
# 3/3: running   [==================================================>]
# verify: Service converged

docker service ps hello-world
# ID                  NAME                IMAGE                               NODE                DESIRED STATE       CURRENT STATE             ERROR                         PORTS
# bifkf5lal69e        hello-world.1       dockerinaction/ch11_service_hw:v2   docker-desktop      Running             Running 6 minutes ago
# m7h2aqp9b0ae         \_ hello-world.1   dockerinaction/ch11_service_hw:v1   docker-desktop      Shutdown            Shutdown 7 minutes ago
# ziaq5sxioqkt         \_ hello-world.1   dockerinaction/ch11_service_hw:v1   docker-desktop      Shutdown            Shutdown 42 minutes ago
# ocdk5x65oncf         \_ hello-world.1   dockerinaction/ch11_service_hw:v1   docker-desktop      Shutdown            Failed 12 hours ago       "task: non-zero exit (137)"
# z3gaqgqlwsd5        hello-world.2       dockerinaction/ch11_service_hw:v2   docker-desktop      Running             Running 6 minutes ago
# pojdz4c5snnd         \_ hello-world.2   dockerinaction/ch11_service_hw:v1   docker-desktop      Shutdown            Shutdown 6 minutes ago
# vrftx9q5uj3g        hello-world.3       dockerinaction/ch11_service_hw:v2   docker-desktop      Running             Running 7 minutes ago
# i2e0auzb781j         \_ hello-world.3   dockerinaction/ch11_service_hw:v1   docker-desktop      Shutdown            Shutdown 7 minutes ago

# Service health and rollback
docker service update \
  --image dockerinaction/ch11_service_hw:start-failure \
  hello-world
# hello-world
# overall progress: 0 out of 3 tasks
# 1/3: starting  [============================================>      ]
# 2/3:
# 3/3:
# service update paused: update paused due to failure or early termination of task j71qvdu6xkzochl19up3dy6yq

# The command will exit, but it will continue to attempt to start that container.

docker service ps hello-world # hello-world.3       dockerinaction/ch11_service_hw:start-failure
#ID                  NAME                IMAGE                                          NODE                DESIRED STATE       CURRENT STATE                     ERROR                              PORTS
# bifkf5lal69e        hello-world.1       dockerinaction/ch11_service_hw:v2              docker-desktop      Running             Running 22 minutes ago
# m7h2aqp9b0ae         \_ hello-world.1   dockerinaction/ch11_service_hw:v1              docker-desktop      Shutdown            Shutdown 22 minutes ago
# ziaq5sxioqkt         \_ hello-world.1   dockerinaction/ch11_service_hw:v1              docker-desktop      Shutdown            Shutdown 58 minutes ago
# ocdk5x65oncf         \_ hello-world.1   dockerinaction/ch11_service_hw:v1              docker-desktop      Shutdown            Failed 13 hours ago               "task: non-zero exit (137)"
# z3gaqgqlwsd5        hello-world.2       dockerinaction/ch11_service_hw:v2              docker-desktop      Running             Running 21 minutes ago
# pojdz4c5snnd         \_ hello-world.2   dockerinaction/ch11_service_hw:v1              docker-desktop      Shutdown            Shutdown 21 minutes ago
# is72h444t4tp        hello-world.3       dockerinaction/ch11_service_hw:start-failure   docker-desktop      Running             Starting less than a second ago
# 69ij9fm07ixz         \_ hello-world.3   dockerinaction/ch11_service_hw:start-failure   docker-desktop      Shutdown            Failed 5 seconds ago              "starting container failed: OC…"
# zdv5a6ldr8f3         \_ hello-world.3   dockerinaction/ch11_service_hw:start-failure   docker-desktop      Shutdown            Failed 11 seconds ago             "starting container failed: OC…"
# he2e9qe5t6jo         \_ hello-world.3   dockerinaction/ch11_service_hw:start-failure   docker-desktop      Shutdown            Failed 16 seconds ago             "starting container failed: OC…"
# 50axy0il7ww9         \_ hello-world.3   dockerinaction/ch11_service_hw:start-failure   docker-desktop      Shutdown            Failed 22 seconds ago             "starting container failed: OC…"

# If you run docker service ps hello-world,
# you will see that two of the replicas remain on the old version of the service,
# and the other replica keeps cycling through starting and failed states.
# The deployment cannot proceed. The new version will never start.

docker service update \
  --rollback \
  hello-world
# hello-world
# rollback: manually requested rollback
# overall progress: rolling back update: 3 out of 3 tasks
# 1/3: running   [>                                                  ]
# 2/3: running   [>                                                  ]
# 3/3: running   [>                                                  ]
# verify: Service converged

docker service ps hello-world # hello-world.3       dockerinaction/ch11_service_hw:v2
#ID                  NAME                IMAGE                                          NODE                DESIRED STATE       CURRENT STATE                ERROR                              PORTS
# bifkf5lal69e        hello-world.1       dockerinaction/ch11_service_hw:v2              docker-desktop      Running             Running 33 minutes ago
# m7h2aqp9b0ae         \_ hello-world.1   dockerinaction/ch11_service_hw:v1              docker-desktop      Shutdown            Shutdown 33 minutes ago
# ziaq5sxioqkt         \_ hello-world.1   dockerinaction/ch11_service_hw:v1              docker-desktop      Shutdown            Shutdown about an hour ago
# ocdk5x65oncf         \_ hello-world.1   dockerinaction/ch11_service_hw:v1              docker-desktop      Shutdown            Failed 13 hours ago          "task: non-zero exit (137)"
# z3gaqgqlwsd5        hello-world.2       dockerinaction/ch11_service_hw:v2              docker-desktop      Running             Running 32 minutes ago
# pojdz4c5snnd         \_ hello-world.2   dockerinaction/ch11_service_hw:v1              docker-desktop      Shutdown            Shutdown 32 minutes ago
# b8k72nvkzyid        hello-world.3       dockerinaction/ch11_service_hw:v2              docker-desktop      Running             Running 13 seconds ago
# hi0w31pedifn         \_ hello-world.3   dockerinaction/ch11_service_hw:start-failure   docker-desktop      Shutdown            Shutdown 24 seconds ago
# vwy6aomqu6z8         \_ hello-world.3   dockerinaction/ch11_service_hw:start-failure   docker-desktop      Shutdown            Failed 27 seconds ago        "starting container failed: OC…"
# wa458nsoyy26         \_ hello-world.3   dockerinaction/ch11_service_hw:start-failure   docker-desktop      Shutdown            Failed 32 seconds ago        "starting container failed: OC…"
# v7yt3oimmks7         \_ hello-world.3   dockerinaction/ch11_service_hw:start-failure   docker-desktop      Shutdown            Failed 38 seconds ago        "starting container failed: OC…"

# --update-failure-action
# Use the --update-failure-action flag to tell Swarm that failed deployments should roll back.

# --update-max-failure-ratio
# Suppose you’re running 100 replicas of a service and those are to be run on a large cluster of machines.
docker service update \
  --update-failure-action rollback \
  --update-max-failure-ratio 0.6 \
  --image dockerinaction/ch11_service_hw:start-failure \
  hello-world
# The first one will retry a few times before the delay expires and the next replica deployment starts.
# Immediately after the second replica fails, the whole deployment will be marked as failed and a rollback will be initiated.

# hello-world
# overall progress: rolling back update: 2 out of 3 tasks
# 1/3: running   [>                                                  ]
# 2/3: starting  [=====>                                             ]
# 3/3: running   [>                                                  ]
# rollback: update rolled back due to failure or early termination of task d1hw7e8dwdywx10k08vg039nm
# service rolled back: rollback completed

docker service ps hello-world
# At this point, all the replicas will be running from the dockerinaction/ch11_service_hw:v2 image.

# Health checks and related parameters can be specified at service creation time,
# changed or set on service updates,
# or even specified as image metadata by using the HEALTHCHECK Dockerfile directive.

# Each service replica container (task) will inherit the definition of health and health check configuration from the service.

docker service update \
  --update-failure-action rollback \
  --image dockerinaction/ch11_service_hw:no-health \
  hello-world

docker container ps # no longer marked healthy
# CONTAINER ID        IMAGE                                      COMMAND                  CREATED             STATUS              PORTS               NAMES
# 186e43321bca        dockerinaction/ch11_service_hw:no-health   "/bin/service"           6 minutes ago       Up 6 minutes                            hello-world.2.zi7pya549yc0dht6psjuco3d4
# 8e9f38d86e94        dockerinaction/ch11_service_hw:no-health   "/bin/service"           7 minutes ago       Up 7 minutes                            hello-world.1.pvsqvdcolg2zfyq8f52af0chm
# 307831c58d81        dockerinaction/ch11_service_hw:no-health   "/bin/service"           7 minutes ago       Up 7 minutes                            hello-world.3.e5mp6zhz937sxuzcc7pkvsp9m

# Add the health check metadata
docker service update \
  --health-cmd /bin/httpping \
  --health-interval 10s \
  hello-world

# --no-healthcheck
# you can create or update a service with health checks disabled by using the --no-healthcheck flag

docker service rm hello-world
