{ config, lib, pkgs, ... }:

let
  cfg = config.myModules.stow;
in
{
  options.myModules.stow = {
    enable = lib.mkEnableOption "GNU Stow";
    
    username = lib.mkOption {
      type = lib.types.str;
      description = "Username";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.stow ];

    system.activationScripts.stow.text = ''
      STOW_DIR="/Users/${cfg.username}/dotfiles/stow"
      TARGET_DIR="/Users/${cfg.username}"

      if [ -d "$STOW_DIR" ]; then
        for app_path in "$STOW_DIR"/*; do
          if [ -d "$app_path" ]; then
            app="$(basename "$app_path")"
            /usr/bin/sudo -H -u ${cfg.username} ${pkgs.stow}/bin/stow --no-folding -R -d "$STOW_DIR" -t "$TARGET_DIR" "$app"
          fi
        done
      fi
    '';
  };
}
