{ pkgs, lib, ... }:
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
}
