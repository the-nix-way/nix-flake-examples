# Docker image

> This example is drawn from the [`nix-docker-examples`][nix-docker-examples] project. You can find a wide variety of other Nix + Docker examples there.

Build the image using [Nix] and [load] the result into [Docker]:

```shell
nix build .
docker load < result
```

To run the image:

```shell
alias hello='docker run -t nix-docker-hello:v0.1.0'

hello
```

That should output `Hello, world!`. You can also pass args:

```shell
hello --traditional
# hello, world

hello --greeting "Herzlich willkommen\!"
# Herzlich willkommen!
```

## Build without checking out

You can also build and run the image without having access to this code locally:

```shell
nix build 'github:the-nix-way/nix-flake-examples?dir=docker-image'
docker load < result
docker run -t nix-docker-hello:v0.1.0
```

[docker]: https://docker.com
[load]: https://docs.docker.com/engine/reference/commandline/load
[nix]: https://nixos.org
[nix-docker-examples]: https://github.com/the-nix-way/nix-docker-examples/tree/main/hello
