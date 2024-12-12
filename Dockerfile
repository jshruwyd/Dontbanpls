FROM debian:12
# Install debian and some app
RUN apt-get update && \
    apt-get install -y sudo wget curl gpg tmate && \
    echo 'root:root' | chpasswd && \
    printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    apt-get install -y systemd systemd-sysv dbus dbus-user-session && \
    printf "systemctl start systemd-logind" >> /etc/profile
CMD ["bash"]
ENTRYPOINT ["/sbin/init"]
