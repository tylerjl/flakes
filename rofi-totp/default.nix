{ pkgs, ... }: pkgs.writeShellApplication {
  name = "rofi-totp";
  runtimeInputs = with pkgs; [
    coreutils
    dunst
    libnotify
    yubikey-manager
  ];
  text = builtins.readFile ./rofi-totp.sh;
}
