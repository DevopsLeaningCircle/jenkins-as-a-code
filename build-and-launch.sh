#!/bin/bash
BASE_IMAGE=jenkins/jenkins:latest
IMAGE_NAME=jenkins-server
TAG=latest
# Build Jenkins server docker image
docker build -t $IMAGE_NAME:$TAG --build-arg BASE_IMAGE=$BASE_IMAGE .

# Launch a jenkins server
mkdir /jenkins
docker run -itd -p 8080:8080 --name Jenkins-server -v /jenkins:/var/jenkins_home $IMAGE_NAME:$TAG