{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.stow
    pkgs.git
    pkgs.tmux
    pkgs.fzf
    pkgs.nodejs_24
    pkgs.python3
  ];

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    taps = [
      {
        name = "TheBoredTeam/boring-notch";
        trusted = true;
      }
      {
        name = "anomalyco/tap";
        trusted = true;
      }
      {
        name = "supabase/tap";
        trusted = true;
      }
      {
        name = "nikitabobko/tap";
        trusted = true;
      }
    ];

    brews = [
      # Activate
        "gh"
        "vercel-cli"
        "supabase"

      # Desactivate
        # "opencode"
    ];

    casks = [
      # Dev
        "visual-studio-code"
        "tailscale-app"
        "antigravity"
        "codex-app"
        "orbstack"
        "ghostty"
        "claude"
        "github"

      # Productivity
        "nextcloud"
        "raycast"
        "parsec"

      # Browsers
        "google-chrome"

      # Office
        "microsoft-powerpoint"
        "microsoft-teams"
        "microsoft-excel"
        "microsoft-word"
        "onedrive"

      # School
        "blender"
        "godot"

      # Utilities
        "aerospace"
        "linearmouse"
        "hiddenbar"

      # Desactivate
        # "vibe-island"
        # "zen"
        # "boring-notch"
        # "bitwarden"
    ];
    
    masApps = {
      # "Goodnotes" = 1444383602;
      # "Folder Preview" = 1519948264;
    };
  };
}
