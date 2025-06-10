ARG BASE_IMAGE=jenkins/jenkins:latest
FROM ${BASE_IMAGE}

# Install basic tools if required
USER root
RUN apt-get update && apt-get install -y curl git

USER jenkins

# Diable Setup Wizard dialog
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
# Set CASC_JENKINS_CONFIG env variable 
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc.yaml

# Pre-install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt


# Copy init Groovy scripts to ref, these scripts run one by one when a container launch first time
COPY --chown=jenkins:jenkins init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/
# Copy JCasC configuration to /var/jenkins_home
COPY  --chown=jenkins:jenkins casc.yaml /var/jenkins_home/casc.yaml

# Pre-create Jobs, config, etc. (optiona)
# COPY -chown=jenkins:jenkins  jobs /usr/share/jenkins/ref/jobs

# Expose default Jenkins port
EXPOSE 8080