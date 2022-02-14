#!/bin/bash
set -x
exec > /var/log/user-data.log 2>&1
sleep 10

# Update EC2 instance packages and install Git
sudo yum update -y && sudo install git -y

# Install Docker runtime
sudo amazon-linux-extras install -y docker

# Add ec2-user to docker group
sudo usermod -a -G docker ec2-user

# Start/Enable Docker runtime
sudo systemctl enable docker
sudo service docker start

# Clone code repository
cd /home/ec2-user && git https://github.com/falterfriday/graylog_challenge_ec2.git

# Build docker image
cd /home/ec2-user/graylog_challenge_ec2/app && sudo docker build -t graylog/hello-graylog .

# Create and run docker container
sudo docker run --name graylog-challenge -d -p 8080:80 graylog-challenge/app