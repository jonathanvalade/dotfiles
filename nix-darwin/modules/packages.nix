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
    global.autoUpdate = false;
    onActivation = {
      cleanup = "zap";
      autoUpdate = false;
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
        "zed"
        "tailscale-app"
        "antigravity"
        "chatgpt"
        "orbstack"
        "ghostty"
        "claude"
        "github"
        "google-gemini"

      # Productivity
        "nextcloud"
        "raycast"
        "parsec"
        "clickup"
        "notion"
        "slack"

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
        "boring-notch"
        "linearmouse"
        "aerospace"
        "hiddenbar"

      # Desactivate
        # "vibe-island"
        # "zen"
        # "bitwarden"
    ];
    
    masApps = {
      "CleanMyKeyboard" = 6468120888;
      "Goodnotes" = 1444383602;
      "Xcode" = 497799835;
    };
  };
}
