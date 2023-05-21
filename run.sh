#!/bin/bash

# Predefined variables
IMAGENAME=audi-project/submission:task-1

# Functions for automation

build_docker_image() {
echo -e '\e[42mPLACEHOLDER TEXT\e[49m'
# TODO
sed -i "s.placeholder-image-name.$IMAGENAME.g" Dockerfile
docker build -t $IMAGENAME .
echo -e '\n'
}


apply_k8s_manifest() {
echo -e '\e[42mPLACEHOLDER TEXT\e[49m'
# TODO
sed -i "s.placeholder-image-name.$IMAGENAME.g" k8s/deployment.yaml
echo -e '\n'
}

exposing_port() {
echo -e '\e[42mPLACEHOLDER TEXT\e[49m'

echo -e '\n'
}

run_load_testing() {
echo -e '\e[42mPLACEHOLDER TEXT\e[49m'
# TODO

echo -e '\n'
}

#===========================================

# Main

clear
echo -e '\n'
echo -e '\e[42mAutomation Script for task\e[49m'
echo -e '\n'
build_docker_image()
apply_k8s_manifest()
exposing_port()
run_load_testing()
