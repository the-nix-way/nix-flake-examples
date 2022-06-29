{
  description = "A Nix flake with just the hello package";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Good old nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs";
    # flake-utils is a set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    # Recurse through systems supported by flake-utils
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          # A convenience variable for system-specific Nixpkgs
          pkgs = import nixpkgs { inherit system; };
        in {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs_latest
            ];
          };
        }
      );
}
