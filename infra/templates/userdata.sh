#!/bin/bash

# Print out commands as they're executed
set -x

# Push user-data to output to console logs
exec > /var/log/user-data.log 2>&1

# Sleep!
sleep 10

# Update EC2 instance packages and install Git
sudo yum update -y

# Install Docker runtime
sudo amazon-linux-extras install -y docker

# Add ec2-user to docker group
sudo usermod -a -G docker ec2-user

# Start/Enable Docker runtime
sudo systemctl enable docker
sudo service docker start

# Install Git
sudo yum install git -y

# Clone code repository
cd /home/ec2-user && git clone https://github.com/falterfriday/graylog_challenge_ec2.git

# Build docker image
cd /home/ec2-user/graylog_challenge_ec2/app && sudo docker build -t graylog/hello-graylog .

# Create and run docker container
sudo docker run --name hello-graylog -d -p 8080:8080 graylog/hello-graylog