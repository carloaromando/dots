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

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    onActivation.autoUpdate = false; # Change this when want to update brews
    casks = [
      "iina"
      "dmenu-mac"
    ];
  };

  # Not working
  launchd.user.agents.dmenu = {
    command = "/usr/local/bin/dmenu-mac";
    serviceConfig = {
      StandardErrorPath = "/tmp/dmenu.log";
      StandardOutPath = "/tmp/dmenu.log";
      RunAtLoad = true;
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
