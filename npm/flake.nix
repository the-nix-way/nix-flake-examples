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
        let
          pkgs = nixpkgs.legacyPackages.${system};

          npm = {
            type = "app";
            program = "${pkgs.nodejs_latest}/bin/npm";
          };
        in {
          apps = {
            inherit npm;
          };

          defaultApp = npm;

          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [ nodejs_latest ];
          };
        }
      );
}
