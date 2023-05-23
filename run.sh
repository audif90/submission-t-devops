#!/bin/bash

# Predefined variables
IMAGENAME=audi-project/submission:task-1
HOSTIP=$(hostname -I | sed 's/ *$//') # single liner for cutting trailing space

# Functions for automation

build_docker_image() {
echo -e '\e[42mBuilding Docker Image\e[49m'
docker build -t $IMAGENAME .
echo -e '\n'
}

apply_k8s_manifest() {
echo -e '\e[42mApplying k8s Manifests\e[49m'
sed -i "s.placeholder-image-name.$IMAGENAME.g" k8s/deployment.yaml
kubectl apply -f k8s/deployment.yaml -f k8s/service.yaml
echo -e '\n'
}

exposing_port_with_nginx() {
echo -e '\e[42mExposing using Nginx Reverse Proxy\e[49m'
sed -i "s/placeholder-host-ip/$HOSTIP/g" conf/default.conf
docker run -d --name nginx-reverse-proxy -p 80:80 -v $(pwd)/conf/default.conf:/etc/nginx/conf.d/default.conf:ro nginx:latest
echo -e '\e[42mDone, Server is running at localhost:80\e[49m'
sed -i "s/$HOSTIP/placeholder-host-ip/g" conf/default.conf # reverse the replacing command so we can reuse the conf/default.conf file
echo -e '\n'
}

run_load_testing() {
echo -e '\e[42mRunning Load Testing\e[49m'
# TODO
echo -e '\n'
}

#
#===========================================
# Main

clear # Cleaning the screen
echo -e '\e[42mAutomation Script for task\e[49m'
echo -e '\n'

# Running steps!
build_docker_image
apply_k8s_manifest
exposing_port_with_nginx
# run_load_testing
