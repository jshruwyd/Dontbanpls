# Use the latest Ubuntu image
FROM ubuntu:latest

# Update and install required packages
RUN apt-get update && apt-get install tmate -y \

# Install JupyterLab
RUN tmate

# Expose port 8080
EXPOSE 8080

