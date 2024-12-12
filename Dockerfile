FROM ubuntu:22.04
 #cai dat mot so app
RUN apt-get update && \
    apt-get install -y shellinabox tmate sudo wget openssh-server openssh-client && \
    sudo sed -i 's/^#\?\s*PermitRootLogin\s\+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo 'root:root' | chpasswd && \
    printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    apt-get install -y systemd systemd-sysv dbus dbus-user-session && \
    printf "systemctl start systemd-logind" >> /etc/profile
# Expose the web-based terminal port
EXPOSE 4200
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
ENTRYPOINT ["/sbin/init"]
