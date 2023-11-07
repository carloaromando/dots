{ self, pkgs, config, ... }:
{
  # Configuration common to all macOS systems
  flake = {
    darwinModules = {
      home = {
        home-manager.users.carlo = { pkgs, ... }: {
          imports = [
            self.homeModules.common
          ];
        };
      };

      default.imports = [
        self.darwinModules_.home-manager
        self.darwinModules.home
        self.nixosModules.common
      ];
    };
  };
}