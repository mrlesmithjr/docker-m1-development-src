# FROM mrlesmithjr/centos:7 # FIXME
# FROM mrlesmithjr/centos:8
# FROM mrlesmithjr/debian:10 # FIXME
FROM mrlesmithjr/debian:11
# FROM mrlesmithjr/debian:9 # FIXME
# FROM mrlesmithjr/rocky:8
# FROM mrlesmithjr/ubuntu:16.04 # FIXME
# FROM mrlesmithjr/ubuntu:18.04 # FIXME
# FROM mrlesmithjr/ubuntu:20.04

ENV WRK_DIR /code
ENV container docker
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR ${WRK_DIR}

COPY . ${WRK_DIR}

RUN ${WRK_DIR}/bootstrap.sh

RUN mkdir /var/run/sshd && \
    ssh-keygen -A && \
    /usr/sbin/sshd

# hadolint ignore=DL3013,DL3042
RUN --mount=type=cache,target=/root/.cache pip3 install --upgrade pip && \
    pip3 install -r ${WRK_DIR}/requirements.txt \
    -r ${WRK_DIR}/requirements-dev.txt

# Add vagrant user and key for SSH
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN useradd --create-home -s /bin/bash vagrant && \
    echo -n 'vagrant:vagrant' | chpasswd && \
    echo 'vagrant ALL = NOPASSWD: ALL' > /etc/sudoers.d/vagrant && \
    chmod 440 /etc/sudoers.d/vagrant && \
    mkdir -p /home/vagrant/.ssh && \
    chmod 700 /home/vagrant/.ssh && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ==" > /home/vagrant/.ssh/authorized_keys && \
    chmod 600 /home/vagrant/.ssh/authorized_keys && \
    chown -R vagrant:vagrant /home/vagrant/.ssh && \
    sed -i -e 's/Defaults.*requiretty/#&/' /etc/sudoers && \
    sed -i -e 's/\(UsePAM \)yes/\1 no/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
