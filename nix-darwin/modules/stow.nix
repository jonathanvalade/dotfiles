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

    system.activationScripts.postActivation.text = lib.mkAfter ''
      echo >&2 "Applying GNU Stow configuration..."
      STOW_DIR="/Users/${cfg.username}/dotfiles/stow"
      TARGET_DIR="/Users/${cfg.username}"

      if [ ! -d "$STOW_DIR" ]; then
        echo >&2 "Stow directory not found: $STOW_DIR"
        exit 1
      fi

      failed=0
      for app_path in "$STOW_DIR"/*; do
        [ -d "$app_path" ] || continue
        app="$(basename "$app_path")"

        echo >&2 "Stowing $app..."
        if ! /usr/bin/sudo -H -u ${cfg.username} ${pkgs.stow}/bin/stow \
          --no-folding \
          --restow \
          --dir="$STOW_DIR" \
          --target="$TARGET_DIR" \
          "$app"; then
          echo >&2 "Failed to stow $app"
          failed=1
        fi
      done

      if [ "$failed" -ne 0 ]; then
        echo >&2 "One or more Stow packages failed"
        false
      fi
    '';
  };
}
