{ config, lib, hostname, computerName, ... }:

let
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
      AirDrop = false;
      Bluetooth = false;
      Display = false;
      FocusModes = false;
      NowPlaying = false;
      Sound = false;
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

  system.activationScripts.postActivation.text = lib.mkAfter ''
    echo >&2 "Creating user folders..."
    /usr/bin/install -d -o ${username} -g staff "${screenshotLocation}"
    /usr/bin/install -d -o ${username} -g staff "/Users/${username}/Developer"

    echo >&2 "Configuring Finder list icon size..."
    finderPreferences="/Users/${username}/Library/Preferences/com.apple.finder.plist"

    if [[ -f "$finderPreferences" ]]; then
      /usr/libexec/PlistBuddy \
        -c "Set :StandardViewSettings:ListViewSettings:iconSize 32" \
        -c "Set :StandardViewSettings:ExtendedListViewSettingsV2:iconSize 32" \
        "$finderPreferences"
      /usr/sbin/chown ${username}:staff "$finderPreferences"
    fi
  '';
}
