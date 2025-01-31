{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.dmenu;
in
{
  options = {
    services.dmenu = {
      enable = mkEnableOption "Whether to enable dmenu.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs.nixcasks; [ dmenu-mac ];

    launchd.user.agents.dmenu = {
      serviceConfig.ProgramArguments = [ "${pkgs.nixcasks.dmenu-mac}/bin/dmenu-mac" ];
      serviceConfig.KeepAlive = true;
      serviceConfig.RunAtLoad = true;
    };
  };
}
