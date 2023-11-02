{
  description = "Collected flake packages of tylerjl.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        packages.stacer = pkgs.callPackage ./stacer {};
        packages.rofi-totp = pkgs.callPackage ./rofi-totp {};
        packages.rofi-ttv = pkgs.callPackage ./rofi-ttv {};
        defaultPackage = self.packages.${system}.stacer;
      }
    ) // {
      overlay = final: prev: {
        rofi-ttv = prev.callPackage ./rofi-ttv {};
        rofi-totp = prev.callPackage ./rofi-totp {};
        stacer = prev.callPackage ./stacer {};
      };
    };
}
