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
    let
      cargoToml = (builtins.fromTOML (builtins.readFile ./Cargo.toml));
      metadata = cargoToml.package;
      pkgName = metadata.name;
      naerskOverlay = final: prev: {
        pkgName = final.callPackage ./. { inherit naersk metadata; };
      };
      overlays = [ naerskOverlay ];
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        packages = {
          pkgName = pkgs.pkgName;
          default = pkgs.pkgName;
        };

        apps.pkgName = flake-utils.lib.mkApp {
          drv = packages.pkgName;
        };

        defaultApp = apps.pkgName;

        devShells.default = pkgs.mkShell {
          inputsFrom = [
            pkgs.pkgName
          ];
          buildInputs = with pkgs; [
            rustfmt
            nixpkgs-fmt
          ];
        };

        checks = {
          format = pkgs.runCommand "check-format"
            {
              buildInputs = with pkgs; [ rustfmt cargo ];
            } ''
            ${pkgs.rustfmt}/bin/cargo-fmt fmt --manifest-path ${./.}/Cargo.toml -- --check
            ${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt --check ${./.}
            touch $out
          '';

          pkgName = pkgs.pkgName;
        };
      in
      {
        inherit packages apps defaultApp devShells checks;
      }
    );
}
