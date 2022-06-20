{
  description = "A Nix flake for use with a JavaScript project";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Good old nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs";
    # flake-utils is a set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
    # Naersk is a utility library for working with Rust
    naersk.url = "github:nmattia/naersk";
  };

  outputs = { self, nixpkgs, flake-utils, naersk }:
    # Recurse through systems supported by flake-utils
    flake-utils.lib.eachDefaultSystem
      (system:
        let
           pkgs = nixpkgs.legacyPackages.${system};
          cargoToml = (builtins.fromTOML (builtins.readFile ./Cargo.toml));
        in {
          devShell =
        };
      );
}
