{ ... }:

let
  username = "jonathan.valade";
in
{
  system.stateVersion = 7;
  system.primaryUser = username;

  # Enable Zsh shell configuration via nix-darwin
  programs.zsh.enable = true;

  # Determinate Nix manages the daemon and nix.conf.
  nix.enable = false;

  imports = [
    ./modules/system.nix
    ./modules/packages.nix
    ./modules/stow.nix
  ];

  myModules.stow = {
    enable = true;
    username = username;
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = username;
    autoMigrate = true;
  };
}
