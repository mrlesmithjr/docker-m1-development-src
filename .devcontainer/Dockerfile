# ARG IMAGE=mrlesmithjr/centos:7 # FIXME
# ARG IMAGE=mrlesmithjr/centos:8 # FIXME
# ARG IMAGE=mrlesmithjr/debian:10 # FIXME
# ARG IMAGE=mrlesmithjr/debian:11
# ARG IMAGE=mrlesmithjr/debian:9 # FIXME
# ARG IMAGE=mrlesmithjr/rocky:8 # FIXME
# ARG IMAGE=mrlesmithjr/ubuntu:16.04 # FIXME
# ARG IMAGE=mrlesmithjr/ubuntu:18.04 # FIXME
# ARG IMAGE=mrlesmithjr/ubuntu:20.04
ARG IMAGE=mrlesmithjr/ubuntu:22.04
# ARG IMAGE=mrlesmithjr/docker-m1-development

# hadolint ignore=DL3006
FROM ${IMAGE}

ARG USER_GID=1000
ARG USER_UID=1000
ARG USERNAME=vscode

ENV container="docker"
ENV DEBIAN_FRONTEND="noninteractive"
ENV DOTFILES_DIR="/home/${USERNAME}/.dotfiles"
ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"
ENV SHELL="/bin/bash"
ENV WRK_DIR="/code"

WORKDIR ${WRK_DIR}

COPY . ${WRK_DIR}

RUN ${WRK_DIR}/config/bootstrap.sh

RUN groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} && \
    echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

RUN mkdir /commandhistory && \
    touch /commandhistory/.bash_history && \
    chown -R ${USERNAME} /commandhistory

USER ${USERNAME}

# hadolint ignore=DL3013
RUN git clone https://github.com/mrlesmithjr/dotfiles.git ${DOTFILES_DIR} \
    --recursive && \
    cp ${WRK_DIR}/config/install.conf.yaml ${DOTFILES_DIR} && \
    ${DOTFILES_DIR}/install && \
    pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir -r "${DOTFILES_DIR}/requirements.txt" \
    -r "${DOTFILES_DIR}/requirements-dev.txt"

# hadolint ignore=SC2086
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" && \
    echo $SNIPPET >> "/home/${USERNAME}/.bashrc"

VOLUME [ "/home/${USERNAME}/Git_Projects", "/home/${USERNAME}/Playground", "/commandhistory", "/home/${USERNAME}/Projects" ]
