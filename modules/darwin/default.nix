{ self, ... }:
{
  # Configuration common to all macOS systems
  flake = {
    darwinModules = {
      home = {
        home-manager.users.carlo = { pkgs, ... }: {
          imports = [
            self.homeModules.default
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
