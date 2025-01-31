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

  services.dmenu.enable = false;

  services.nfs.server = {
    enable = false;
    exports = ''
      /System/Volumes/Data -ro -alldirs 192.168.64.3
    '';
  };

  services.pueue.enable = true;
  services.tailscale.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  nix.linux-builder.enable = false;

  system.stateVersion = 4;
}



