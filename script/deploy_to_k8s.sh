#!/bin/bash

# Predefined variables
IMAGENAME=audi-project/submission:task-1

apply_k8s_manifest() {
echo -e '\e[42mApplying k8s Manifests\e[49m'
sed -i "s.placeholder-image-name.$IMAGENAME.g" ../k8s/deployment.yaml
kubectl apply -f ../k8s/deployment.yaml -f ../k8s/service.yaml
echo -e '\n'
}

#
#===========================================
# Main

clear # Cleaning the screen
echo -e '\e[42mAutomation Script for task : Build Docker Image\e[49m'
echo -e '\n'

# Running steps!
apply_k8s_manifest
