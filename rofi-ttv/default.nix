{ pkgs, lib, ... }:
with pkgs ; stdenv.mkDerivation rec {
  pname = "rofi-ttv";
  version = "20250204";
  src = fetchFromGitHub {
    owner = "tylerjl";
    repo = pname;
    rev = "bbf2610c17eca490b92035c23a2360e255170a0e";
    sha256 = "sha256-TbaEOsREJ4idMf28wBE9szBTwfOvgK5v90hrJPaljFY=";
  };
  installPhase = ''
    install -vd $out/bin
    install -vm 755 rofi-ttv $out/bin
  '';
  meta = {
    description = "Dynamic menu interface for twitch";
    homepage = "https://github.com/tylerjl/rofi-ttv";
    platforms = [ "x86_64-linux" ];
  };
  buildInputs = [ curl jq rofi mpv yt-dlp ];
}
