#!/bin/bash
set -x # echo on

# make the "Makefile"
make app-image

# "$BUILD_ID": cannot get this value after execute "make app-images"
# [START] Workaround: Write "$BUILD_ID" to ./target/build-id
BUILD_ID=$(cat ./target/build-id)
echo "$BUILD_ID"
# [END]

# Built App Image. BUILD_ID: 20200413-165350-7c23b78
# make inspect-image-labels BUILD_ID=20200413-165350-7c23b78
make inspect-image-labels BUILD_ID="$BUILD_ID"
#{
#          "org.label-schema.build-date": "2019-07-02T10:36:19Z",
#          "org.label-schema.name": "ch10",
#          "org.label-schema.schema-version": "1.0rc1",
#          "org.label-schema.vcs-ref": "ade3d65",
#          "org.label-schema.version": "20190702-223619-ade3d65"
#}

make image-tests BUILD_ID="$BUILD_ID"
#Testing image structure
#docker container run --rm -it \
#    -v /var/run/docker.sock:/var/run/docker.sock \
#    -v /Users/dia/structure-tests.yaml:/structure-tests.yaml \
#    gcr.io/gcp-runtimes/container-structure-test:v1.6.0 test \
#    --image dockerinaction/ch10:20181230-181226-61ceb6d \
#    --config /structure-tests.yaml
#=============================================
#====== Test file: structure-tests.yaml ======
#=============================================
#INFO: stderr: openjdk version "11.0.3" 2019-04-16
#OpenJDK Runtime Environment 18.9 (build 11.0.3+7)
#OpenJDK 64-Bit Server VM 18.9 (build 11.0.3+7, mixed mode)
#=== RUN: Command Test: java version
#--- PASS
#stderr: openjdk version "11.0.3" 2019-04-16
#OpenJDK Runtime Environment 18.9 (build 11.0.3+7)
#OpenJDK 64-Bit Server VM 18.9 (build 11.0.3+7, mixed mode)
#INFO: File Existence Test: application archive
#=== RUN: File Existence Test: application archive
#--- PASS
#=============================================
#================== RESULTS ==================
#=============================================
#Passes:      2
#Failures:    0
#Total tests: 2
#PASS

make tag BUILD_ID=$BUILD_ID TAG=1.0.0
