{ self, ... }:
{
  flake = {
    nixosModules = {
      common.imports = [
        ./nix.nix
      ];

      home-base = {
        home-manager.users.carlo = { pkgs, ... }: {
          imports = [
            self.homeModules.base
          ];
        };
      };

      minimal.imports = [
        self.nixosModules.home-manager
        self.nixosModules.home-base
        self.nixosModules.common
      ];
    };
  };
}
