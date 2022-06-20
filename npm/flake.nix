{
  description = "A Nix flake for use with a JavaScript project";

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
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          packages = with pkgs; {
            # Import the hello package
            inherit node;

            # Set the default package
            default = node;
          };
        }
      );
}
