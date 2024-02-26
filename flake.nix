{
  description = "Carlo's Nix systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nixpkgs-old pinned to revision: a0b3b06b7a82c965ae0bb1d59f6e386fe755001d because _coder_ is broken on the last unstable
    # opened issue: https://github.com/NixOS/nixpkgs/issues/266037
    nixpkgs-old.url = "github:NixOS/nixpkgs/835736de35faba3e57a7a4becc6b7e472ae72317";

    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixos-flake.url = "github:srid/nixos-flake";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcasks = {
      url = "github:jacekszymanski/nixcasks";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; }
      {
        systems = [ "x86_64-darwin" "x86_64-linux" ];

        imports = [
          inputs.nixos-flake.flakeModule
          ./modules/nixos
          ./modules/home
          ./modules/darwin
        ];

        flake = {
          # Configurations for macOS machines
          darwinConfigurations = {
            invernomuto = self.nixos-flake.lib.mkMacosSystem {
              nixpkgs.hostPlatform = "x86_64-darwin";

              imports = [
                self.darwinModules.default
                ./hosts/invernomuto
                ./modules/darwin/services/nfsd.nix
                ./modules/darwin/services/dmenu.nix
              ];
            };
          };

          # Configurations for NixOS systems
          nixosConfigurations = {
            # UTM macOS VM
            cthell = self.nixos-flake.lib.mkLinuxSystem {
              nixpkgs.hostPlatform = "x86_64-linux";

              imports = [
                self.nixosModules.minimal
                ./hosts/cthell
              ];
            };
          };
        };
      };
}
