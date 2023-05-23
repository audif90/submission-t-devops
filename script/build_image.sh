#!/bin/bash

# Predefined variables
IMAGENAME=audi-project/submission:task-1

build_docker_image() {
echo -e '\e[42mBuilding Docker Image\e[49m'
docker build -t $IMAGENAME ..
echo -e '\n'
}

#
#===========================================
# Main

clear # Cleaning the screen
echo -e '\e[42mAutomation Script for task : Build Docker Image\e[49m'
echo -e '\n'

# Running steps!
build_docker_image