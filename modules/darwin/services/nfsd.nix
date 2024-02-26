{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.nfs.server;
  exports = pkgs.writeText "exports" cfg.exports;
in
{
  options = {
    services.nfs = {
      server = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = mdDoc ''
            Whether to enable the NFS server.
          '';
        };

        exports = mkOption {
          type = types.lines;
          default = "";
          description = mdDoc ''
            Contents of the /etc/exports file.  See
            {manpage}`exports(5)` for the format.
          '';
        };
      };
    };
  };

  config = mkIf cfg.enable {
    launchd.daemons.nfsdstart = {
      script = "nfsd enable && nfsd start";
      serviceConfig.RunAtLoad = true;
      serviceConfig.KeepAlive.SuccessfulExit = false;
    };
    environment.etc.exports.source = exports;
  };
}
