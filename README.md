# Deploy Jenkins Server

Deploy jenkins server using docker automatically. An automated way to create and deploy Jenkins Server using 'jenkins/jenkins' base image.


### Prerequisites
1. Install docker in the machine

### Step to deploy
1. Add +x permission to ***build-and-launch.sh*** file.
2. Set +r permission to plugins.txt, casc.yaml and init.groovy.d/basic-security.groovy
3. Run ***build-and-launch.sh*** file, this file will build the docker image and start a container from new image on port 8080.
