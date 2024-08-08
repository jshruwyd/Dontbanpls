# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install required tools
RUN apt-get update -y && \
    apt-get install -y git qemu-kvm  wget curl && \
        wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
        RUN curl -fsSL http://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-virt-3.12.3-x86_64.iso
        RUN git clone https://github.com/novnc/noVNC.git
# Run tar -xf ngrok*
RUN tar -xf ngrok*

# Run ./ngrok
RUN ./ngrok config add-authtoken 2ir65LdPzrkSUCkPFd4SB8Q2sCY_6zNwoNfgsuqC2FDutZbwM

# Run nohup ./ngrok
RUN nohup ./ngrok http 6081

# RUN mkdir
RUN mkdir alpine && cd $_

# Run Qemu-img 
RUN qemu-img create -f qcow2 alpine.img 30G

# Run Qemu
RUN qemu-system-x86_64 -machine q35 -m 2048 -smp cpus=2 -cpu qemu64 -netdev user,id=n1,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 -nographic alpine.img -vnc :5901 &>/dev/null &

# Run novnc 
RUN cd noVNC && ./utils/novnc_proxy --vnc localhost:5901 --listen localhost:6081

