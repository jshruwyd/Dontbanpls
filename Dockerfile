# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install required tools
RUN apt-get update -y && \
    apt-get install -y unzip wget docker.io tmate curl && \
        curl -fsSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz | sh
# Unzip
RUN unzip ngrok"
    ./ngrok config add-authtoken 2ir65LdPzrkSUCkPFd4SB8Q2sCY_6zNwoNfgsuqC2FDutZbwM
    nohup ./ngrok http 8080
    
# Tmate
RUN docker run --privileged --shm-size 1g -d -p 8080:10000 -e VNC_PASSWD=password -e PORT=10000 -e AUDIO_PORT=1699 -e WEBSOCKIFY_PORT=6900 -e VNC_PORT=5900 -e SCREEN_WIDTH=1024 -e SCREEN_HEIGHT=768 -e SCREEN_DEPTH=24 thuonghai2711/ubuntu-novnc-pulseaudio:22.04
