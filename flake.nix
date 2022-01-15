{
  description = "Collected flake packages of tylerjl.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.stacer = pkgs.callPackage ./stacer {};
        packages.rofi-ttv = pkgs.callPackage ./rofi-ttv {};
        defaultPackage = self.packages.${system}.stacer;
      }
    ) // {
      overlay = final: prev: {
        rofi-ttv = prev.callPackage ./rofi-ttv {};
        stacer = prev.callPackage ./stacer {};
      };
    };
}
