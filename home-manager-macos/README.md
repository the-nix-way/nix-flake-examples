# Home Manager with a Nix flake

**WARNING**: don't run this if you're already using Home Manager, as it overrides your current config.

First, make sure that a `USER` env var is present in your environment. Then:

```shell
nix build ".#homeConfigurations.${USER}.activationPackage"
./result/bin/home-manager-generation
```

Also possible:

```shell
home-manager switch --flake .#change-me
```
