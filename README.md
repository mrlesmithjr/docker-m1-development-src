# vagrant-docker-m1-development

## Dockerfile

By default [Dockerfile.debian](Dockerfile.debian) is used. But you can use
[Dockerfile.rhel](Dockerfile.rhel) to spin up a RHEL based container by executing:

```bash
export DOCKERFILE=Dockerfile.rhel
```

## Usage

Quickly spin up a Docker container using Vagrant.

```bash
vagrant up
```

By default, SSH is running in the container so you can use `vagrant ssh` to connect to
it.

## Licensing

The current licensing model is MIT by default.

## Author Information

Larry Smith Jr.

- [@mrlesmithjr](https://twitter.com/mrlesmithjr)
- [EverythingShouldBeVirtual](http://everythingshouldbevirtual.com)
- [mrlesmithjr@gmail.com](mailto:mrlesmithjr@gmail.com)
