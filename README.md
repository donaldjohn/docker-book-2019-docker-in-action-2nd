![](https://img.shields.io/badge/language-shell-blue)
![](https://img.shields.io/badge/technology-docker,%20dockerfile,%20swarm-blue)
![](https://img.shields.io/badge/development%20year-2019-orange)
![](https://img.shields.io/badge/contributor-shijian%20su-purple)
![](https://img.shields.io/badge/license-MIT-lightgrey)

![](https://img.shields.io/github/languages/top/shijiansu/docker-book-2019-docker-in-action-2nd)
![](https://img.shields.io/github/languages/count/shijiansu/docker-book-2019-docker-in-action-2nd)
![](https://img.shields.io/github/languages/code-size/shijiansu/docker-book-2019-docker-in-action-2nd)
![](https://img.shields.io/github/repo-size/shijiansu/docker-book-2019-docker-in-action-2nd)
![](https://img.shields.io/github/last-commit/shijiansu/docker-book-2019-docker-in-action-2nd?color=red)

--------------------------------------------------------------------------------

- part 1 process isolation and environment independent computing
  - 1 welcome to docker
  - 2 running software in container
  - 3 software installation simplified
  - 4 working with storage and volumes
  - 5 single host networking
  - 6 limiting risk with resource controls
- part 2 packaging software for distribution
  - 7 packaging software in images
  - 8 building images automatically with dockerfiles
  - 9 public and private software distribution
  - 10 image pipelines
- part 3 higher level abstractions and orchestration
  - 11 services with docker and compose
  - 12 first class configuration abstractions
  - 13 orchestrating services on a cluster of docker hosts with swarm

--------------------------------------------------------------------------------

# Some docker command for lib

```shell script
docker stop $(docker ps -q) # stop all dockers
docker stop ch6_wordpress && docker rm ch6_wordpress # stop and remove

docker container rm -vf ch6_wordpress # forced kill and also clean volumes

docker system df # show used space, similar to the unix tool df
docker system prune # remove all unused data.
```

# Execute all tests in repo

`/bin/bash run-repo-test.sh`
