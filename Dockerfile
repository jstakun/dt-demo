FROM registry.redhat.io/openshift3/jenkins-slave-base-rhel7

MAINTAINER Jaroslaw Stakun <jstakun@redhat.com>

LABEL version="1.0" \
      description="This is Jenkins slave which includes Python3 and Dynatrace scripts" \
      creationDate="2019-01-10"

LABEL io.k8s.description="This is Jenkins slave which includes Python3 and Dynatrace scripts" \
      io.k8s.display-name="Jenkins Slave Python3 Dynatrace " \
      io.openshift.tags="jenkins, slave"

ENV DT_HOME=/opt/dt

USER root

RUN yum-config-manager --enable rhel-7-server-optional-rpms --enable rhel-server-rhscl-7-rpms > /dev/null && \
    yum install -y rh-python36 && \
    yum clean all && \ 
    ln -s /opt/rh/rh-python36/root/usr/bin/python3 /usr/bin/python3 && \
    python3 -V && \
    python3 -m pip install requests

COPY ./dynatrace-scripts $DT_HOME/dynatrace-scripts

COPY ./dynatrace-cli $DT_HOME/dynatrace-cli

RUN adduser -g 0 -c "Jenkins user" -p jenkins jenkins && \
    chown -R jenkins:root $DT_HOME

USER jenkins
