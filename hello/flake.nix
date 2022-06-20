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
        # Use a convenience variable for all nixpkgs packages for the specified system
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          packages = with pkgs; {
            # Import the hello package
            inherit hello;

            # Set the default package
            default = hello;
          };
        }
      );
}
