# ARG IMAGE=mrlesmithjr/centos:7 # FIXME
# ARG IMAGE=mrlesmithjr/centos:8 # FIXME
# ARG IMAGE=mrlesmithjr/debian:10 # FIXME
# ARG IMAGE=mrlesmithjr/debian:11
# ARG IMAGE=mrlesmithjr/debian:9 # FIXME
# ARG IMAGE=mrlesmithjr/rocky:8 # FIXME
# ARG IMAGE=mrlesmithjr/ubuntu:16.04 # FIXME
# ARG IMAGE=mrlesmithjr/ubuntu:18.04 # FIXME
# ARG IMAGE=mrlesmithjr/ubuntu:20.04
ARG IMAGE=mrlesmithjr/debian:11

# hadolint ignore=DL3006
FROM ${IMAGE}

ARG USER_GID=1000
ARG USER_UID=1000
ARG USERNAME=vscode

ENV LC_ALL="C.UTF-8"
ENV LANG="C.UTF-8"
ENV SHELL="/bin/bash"
ENV WRK_DIR="/code"
ENV container="docker"

WORKDIR ${WRK_DIR}

COPY . ${WRK_DIR}

RUN ${WRK_DIR}/bootstrap.sh

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

# hadolint ignore=DL3013,DL3042
RUN --mount=type=cache,target=/home/$USERNAME/.cache pip3 install --upgrade pip && \
    pip3 install -r ${WRK_DIR}/requirements.txt \
    -r ${WRK_DIR}/requirements-dev.txt
