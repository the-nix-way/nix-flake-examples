{ pkgs }:

let
  homePackages = with pkgs; [ hello ];
in homePackages