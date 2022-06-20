{
  description = "Home manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, home-manager }:
    let
      username = "change-me";
      system = "aarch64-darwin";
      stateVersion = "22.05";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit stateVersion system username;

        homeDirectory = "/Users/${username}";

        pkgs = nixpkgs.legacyPackages.${system};

        configuration = { pkgs, ... }: {
          programs = {
            home-manager = {
              enable = true;
            };
          };

          home = {
            packages = import ./packages.nix { inherit pkgs; };
            sessionVariables = {
              WELCOME = "Welcome to your flake-driven Home Manager config";
            };
          };
        };
      };
    };
}