# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.provider "docker" do |docker, override|
        override.vm.box = nil
        docker.build_dir = "."
        override.ssh.insert_key = true
        docker.has_ssh = true
        docker.privileged = true
      end
end
