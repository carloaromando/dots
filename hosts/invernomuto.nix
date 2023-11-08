{ pkgs, ... }:

# See darwin/default.nix for other modules in use.
let
  username = "carlo";
in
{
  environment.systemPackages = with pkgs; [
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
    taps = [
      "d12frosted/emacs-plus"
    ];
    brews = [
      {
        name = "emacs-plus";
        args = [
          "with-imagemagick"
          "with-poll"
          "with-nobu417-big-sur-icon"
        ];
        start_service = true;
        restart_service = true;
        link = true;
      }
    ];
  };

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
