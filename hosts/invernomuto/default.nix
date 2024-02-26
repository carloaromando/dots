{ pkgs, ... }:

let
  username = "carlo";
in
{
  environment.systemPackages = with pkgs; [
    git
    zsh
    curl
    wget
    micro
    htop
  ];

  security.pam.enableSudoTouchIdAuth = true;

  programs.zsh.enable = true;

  # For home-manager to work.
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  networking.hostName = "invernomuto";

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    onActivation.autoUpdate = false; # Change this when want to update brews
    brews = [
      "handbrake"
    ];
    casks = [
      "iina"
      "vlc"
      # "utm"
    ];
  };

  services.dmenu.enable = true;
  services.nfs.server = {
    enable = true;
    exports = ''
      /System/Volumes/Data -ro -alldirs 192.168.64.3
    '';
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  nix.linux-builder.enable = true;

  system.stateVersion = 4;
}



