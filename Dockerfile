# Use the latest Ubuntu image
FROM ubuntu:latest

# Update and install required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    wget \

# Set the working directory
WORKDIR /app

# Install JupyterLab
RUN tmate

# Expose port 8080
EXPOSE 8080

