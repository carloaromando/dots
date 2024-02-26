{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.dmenu;
in
{
  options = {
    services.dmenu = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Whether to enable dmenu.
        '';
      };
    };
  };


  config = mkIf cfg.enable {
    homebrew.casks = [ "dmenu-mac" ];

    launchd.user.agents.dmenu = {
      serviceConfig.ProgramArguments = [ "/usr/local/bin/dmenu-mac" ];
      serviceConfig.KeepAlive = true;
      serviceConfig.RunAtLoad = true;
    };
  };
}
