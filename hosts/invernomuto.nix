{ pkgs, flake, ... }:

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

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}