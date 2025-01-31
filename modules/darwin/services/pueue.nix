{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.pueue;
  yamlFormat = pkgs.formats.yaml { };
  configFile =
    yamlFormat.generate "pueue.yaml" ({ shared = { }; } // cfg.settings);
in
{
  options = {
    services.pueue = {
      enable = mkEnableOption "Pueue, CLI process scheduler and manager";

      package = mkPackageOption pkgs "pueue" { };

      settings = mkOption {
        type = yamlFormat.type;
        default = { };
        example = literalExpression ''
          {
            daemon = {
              default_parallel_tasks = 2;
            };
          }
        '';
        description = ''
          Configuration written to
          {file}`$XDG_CONFIG_HOME/pueue/pueue.yml`.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    environment.etc."pueue/pueue.yml".source = configFile;
    environment.variables = {
      PUEUE_CONFIG_PATH = "/etc/pueue/pueue.yml";
    };

    launchd.user.agents.pueued = {
      serviceConfig.ProgramArguments = [ "${cfg.package}/bin/pueued" "-v" "-c" "${configFile}" ];
      serviceConfig.KeepAlive = true;
      serviceConfig.RunAtLoad = true;
    };
  };
}
