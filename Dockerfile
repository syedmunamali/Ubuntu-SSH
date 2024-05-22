FROM ubuntu:latest

RUN mkdir -p /var/run/sshd

RUN apt update && \
    apt install -y openjdk-8-jdk && \
    apt install -y openssh-server sudo

RUN useradd -u 999 -rm -d /home/remote_user -s /bin/bash remote_user && \
    echo remote_user:password1234 | chpasswd

RUN usermod -aG sudo remote_user

RUN mkdir /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

COPY id_rsa.pub /home/remote_user/.ssh/authorized_keys

RUN chown remote_user:remote_user -R /home/remote_user/.ssh && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

CMD [ "/usr/sbin/sshd" , "-D" ]


# ssh-kegen -t rsa -m PEM -f id_rsa
# cd 
# 779  ll .ssh/
# 780  rm -rf .ssh/id_rsa
# 781  rm -rf .ssh/id_rsa.pub 
# 782  cd -
# 783  ll
# 784  cp -prfv id_rsa* ~/.ssh/
# ssh remote_user@localhost -p PORT_NUMBER_SPECIFIED_ON_DOCKER_RUN
