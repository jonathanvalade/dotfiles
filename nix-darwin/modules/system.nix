{ config, hostname, computerName, ... }:

let
  showInMenuBar = 18;
  hideInMenuBar = 24;
  username = config.system.primaryUser;
  screenshotLocation = "/Users/${username}/Documents/Screenshots";
in

# ============================================================================
# TODO: MANUAL STEPS AFTER INSTALLATION (new Mac)
# ============================================================================
#
# 1. Battery:
#    - Go to System Settings > Battery.
#    - Configure the charge limit to preserve battery health.
#
# ============================================================================

{
  # --- Security & PAM (Touch ID for sudo) ---
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.reattach = true;

  # --- Network Identity ---
  networking = {
    computerName = computerName;
    hostName = hostname;
    localHostName = hostname;
  };

  # --- MacOS System Defaults ---
  system.defaults = {

    controlcenter = {
      AirDrop = hideInMenuBar;
      BatteryShowPercentage = true;
      Bluetooth = hideInMenuBar;
      Display = hideInMenuBar;
      FocusModes = hideInMenuBar;
      NowPlaying = hideInMenuBar;
      Sound = showInMenuBar;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = false;
      AppleKeyboardUIMode = 2;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
    };

    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.15;
      expose-animation-duration = 0.2;
      expose-group-apps = true;
      mru-spaces = false;
      orientation = "bottom";
      persistent-apps = [
        "/Applications/Safari.app"
        "/System/Applications/Calendar.app"
        "/Applications/Ghostty.app"
        "/Applications/Visual Studio Code.app"
      ];
      show-recents = false;
      tilesize = 48;
    };

    finder = {
      AppleShowAllExtensions = true;
      CreateDesktop = false;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      NewWindowTarget = "Home";
      QuitMenuItem = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXSortFoldersFirst = true;
    };

    trackpad = {
      Clicking = true;
      TrackpadFourFingerHorizSwipeGesture = 2;
      TrackpadFourFingerVertSwipeGesture = 2;
      TrackpadThreeFingerDrag = true;
      TrackpadThreeFingerHorizSwipeGesture = 0;
      TrackpadThreeFingerTapGesture = 0;
      TrackpadThreeFingerVertSwipeGesture = 0;
    };

    screencapture = {
      disable-shadow = true;
      location = screenshotLocation;
      target = "file";
      type = "png";
    };

    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 0;
    };

    loginwindow = {
      GuestEnabled = false;
      LoginwindowText = "Jo's MacBook Pro";
    };
  };

  system.activationScripts.screenshotFolder.text = ''
    /usr/bin/install -d -o ${username} -g staff "${screenshotLocation}"
  '';

  system.activationScripts.developerFolder.text = ''
    /usr/bin/install -d -o ${username} -g staff "/Users/${username}/Developer"
  '';
}
