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
          # This overlay adds the "rust-bin" package to nixpkgs
          (import rust-overlay)
        ];

        # System-specific nixpkgs with rust-overlay applied
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        # The shell environment
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              # Use the specific version of the Rust toolchain specified by the toolchain file
              (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)

              # Other utilities
              openssl
              exa
              fd
            ];

            shellHook = builtins.readFile ./scripts/shell.sh;
          };
        };
      in {
        inherit devShells;        
      }
    );
}
