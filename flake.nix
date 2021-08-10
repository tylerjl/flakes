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
        packages.stacer =
          with pkgs ; stdenv.mkDerivation rec {
            # { stdenv, cmake, fetchFromGitHub, lib, qtbase, wrapQtAppsHook, qtcharts, qttools }:
            # stdenv.mkDerivation rec {
            pname = "Stacer";
            version = "1.1.0";
            src = fetchFromGitHub {
              owner = "oguzhaninan";
              repo = pname;
              rev = "v" + version;
              sha256 = "0qndzzkbq6abapvwq202kva8j619jdn9977sbqmmfs9zkjz4mbsd";
            };
            buildInputs = [ qt5.qtbase libsForQt5.qtcharts libsForQt5.qttools ];
            nativeBuildInputs = [ cmake qt5.wrapQtAppsHook ];
          };
        defaultPackage = self.packages.${system}.stacer;
      }
    );
  # defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;
}
