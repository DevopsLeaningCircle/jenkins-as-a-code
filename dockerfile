ARG BASE_IMAGE=jenkins/jenkins:latest
FROM ${BASE_IMAGE}

# Install basic tools if required
USER root
RUN apt-get update && apt-get install -y curl git

USER jenkins

# Pre-install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Add Groovy init scripts
COPY init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/

# Pre-create Jobs, config, etc. (optiona)
# COPY jobs /usr/share/jenkins/ref/jobs

# Expose default Jenkins port
EXPOSE 8080