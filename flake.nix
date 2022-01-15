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
            pname = "Stacer";
            version = "1.1.0";
            src = fetchFromGitHub {
              owner = "oguzhaninan";
              repo = pname;
              rev = "v" + version;
              sha256 = "0qndzzkbq6abapvwq202kva8j619jdn9977sbqmmfs9zkjz4mbsd";
            };
            meta = with lib ; {
              description = "Linux System Optimizer and Monitoring";
              homepage = https://github.com/oguzhaninan/Stacer;
              platforms = [ "x86_64-linux" ];
            };
            buildInputs = [ qt5.qtbase libsForQt5.qtcharts libsForQt5.qttools ];
            nativeBuildInputs = [ cmake qt5.wrapQtAppsHook ];
          };
        packages.rofi-ttv =
          with pkgs ; stdenv.mkDerivation rec {
            pname = "rofi-ttv";
            version = "20220115";
            src = fetchFromGitHub {
              owner = "loiccoyle";
              repo = pname;
              rev = "e9c722481b740196165f840771b3ae58b7291694";
              sha256 = "sha256-1cvjxulpfOIwipLBa9me4YGLVxSXOAsrFvFq/Q5y0tQ=";
            };
            installPhase = ''
              install -vd $out/bin
              install -vm 755 rofi-ttv $out/bin
            '';
            meta = with lib ; {
              description = "Dynamic menu interface for twitch";
              homepage = https://github.com/loiccoyle/rofi-ttv;
              platforms = [ "x86_64-linux" ];
            };
            buildInputs = [ curl jq rofi mpv ];
          };
        defaultPackage = self.packages.${system}.stacer;
      }
    );
  # defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;
}
