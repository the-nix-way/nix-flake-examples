{
  description = "A Nix flake for use with a JavaScript project";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Good old nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs";
    # flake-utils is a set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
    # A utility library for working with Rust
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [
          (import rust-overlay)
        ];

        pkgs = import nixpkgs {
          inherit system overlays;
        };

        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
            ];

            shellHook = ''
              rm -rf target
            '';
          };
        };
      in {
        inherit devShells;        
      }
    );
}
