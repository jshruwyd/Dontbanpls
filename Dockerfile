FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y tmate sudo wget neofetch docker.io docker-compose openssh-server openssh-client && \
    sudo sed -i 's/^#\?\s*PermitRootLogin\s\+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo 'root:root' | chpasswd && \
    printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    apt-get install -y systemd systemd-sysv dbus dbus-user-session && \
    printf "systemctl start systemd-logind" >> /etc/profile
    echo 'PS1="\[\033[0;32m\]root\[\033[0m\]@\[\033[0;34m\]dockercontainer\[\033[0m\]:\w\$ "' >> /root/.bashrc
CMD ["bash"]
ENTRYPOINT ["/sbin/init"]
