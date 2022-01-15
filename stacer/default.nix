{ pkgs, lib, ... }:
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
}
