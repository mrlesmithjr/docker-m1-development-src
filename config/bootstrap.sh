#!/bin/bash

# Debian/Ubuntu
if [ -f /etc/debian_version ]; then
    apt-get update -y
    apt-get install -y --no-install-recommends ca-certificates curl fontconfig \
        fonts-font-awesome git gnupg libffi-dev lsb-release openssh-client \
        python3-pip python3-setuptools ssh sudo systemd vim wget zsh
    # shellcheck source=/dev/null
    source /etc/os-release
    id=$ID
    if [[ $id == "debian" ]]; then
        curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
    elif [[ $id == "ubuntu" ]]; then
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
    fi
    apt-get update -y
    apt-get install -y --no-install-recommends docker-ce-cli
    apt-get clean
    rm -rf /var/lib/apt/lists/*
fi

# RHEL
if [ -f /etc/redhat-release ]; then
    yum install -y curl git openssh-clients python3-pip python3-setuptools openssh-server \
        sudo systemd vim wget yum-utils zsh
    yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/rhel/docker-ce.repo
    yum install -y docker-ce-cli
    yum clean all
fi
