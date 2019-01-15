#!/bin/bash

oc new-app --name=jenkins-slave-python3-rhel7 --labels='name=jenkins-slave-python3-rhel7' --code=. --strategy=Docker
oc start-build jenkins-slave-python3-rhel7 --from-dir=.
