{
  description = "Home Manager configuration for macOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, ... }:
    let
      system = "aarch64-darwin";
      username = "change-me";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        # Specify the path to your home configuration here
        configuration = {};

        inherit system username;
        homeDirectory = "/home/${username}";
        stateVersion = "22.05";
      };
    };
}