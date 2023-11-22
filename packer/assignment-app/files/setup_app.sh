#!/bin/bash

# Installing PostgreSQL and Docker
sudo yum install -y postgresql docker || { echo "Installation failed"; exit 1; }

# Enabling Docker 
whoami
sudo systemctl status docker
#sudo usermod -aG docker ec2-user
# sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker

# Building the frontend Docker image
echo "Building frontend-app image..."
cd /home/ec2-user/app/frontend || exit
sudo docker build -t frontend-app -f Dockerfile . || { echo "Building frontend-app failed"; exit 1; }

# Building the backend Docker image
echo "Building backend-app image..."
cd /home/ec2-user/app || exit
sudo docker build -t backend-app -f Dockerfile . || { echo "Building backend-app failed"; exit 1; }

# Displaying the built Docker images
echo "Docker images available:"
sudo docker images