#!/bin/bash

# Debian/Ubuntu
if [ -f /etc/debian_version ]; then
    apt-get update -y &&
        apt-get install -y --no-install-recommends git libffi-dev openssh-client \
            python3-pip python3-setuptools ssh sudo systemd wget zsh &&
        apt-get clean &&
        rm -rf /var/lib/apt/lists/*
fi

# RHEL
if [ -f /etc/redhat-release ]; then
    yum install -y git openssh-clients python3-pip python3-setuptools openssh-server \
        sudo systemd wget zsh &&
        yum clean all
fi
