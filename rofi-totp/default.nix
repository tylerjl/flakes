{ pkgs }: pkgs.writers.writeBashBin "rofi-totp" (builtins.readFile ./rofi-totp.sh)
