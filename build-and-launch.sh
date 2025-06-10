#!/bin/bash

set -e # exit immediately if any command fails

BASE_IMAGE=jenkins/jenkins:latest
IMAGE_NAME=jenkins-server
TAG=latest
CONTAINER_NAME=Jenkins-server

# Set real permisison for plugins.txt, casc.yaml, and init.groovy.d\*
sudo chmod +r plugins.txt casc.yaml
sudo chmod +r init.groovy.d

# Build Jenkins server docker image
docker build -t $IMAGE_NAME:$TAG --build-arg BASE_IMAGE=$BASE_IMAGE .

# Create a directory, option -p ensure no error if the directory already exists
mkdir -p /jenkins 
sudo chmod +rw /jenkins

# Stop and remove container if it exists
if [ "$(docker ps -a -q -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Stopping and removing existing container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Launch a jenkins server
docker run -itd -p 8080:8080 --name Jenkins-server -v /jenkins:/var/jenkins_home $IMAGE_NAME:$TAG

# Running with ldap-env file
# docker --env-file .ldap-env run -itd -p 8080:8080 --name Jenkins-server -v /jenkins:/var/jenkins_home $IMAGE_NAME:$TAG