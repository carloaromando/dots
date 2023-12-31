{
  description = "Carlo's nix system";

  inputs = {
    # nixpkgs pinned to revision: a0b3b06b7a82c965ae0bb1d59f6e386fe755001d because coder is broken on the last unstable
    # opened issue: https://github.com/NixOS/nixpkgs/issues/266037
    nixpkgs.url = "github:NixOS/nixpkgs/835736de35faba3e57a7a4becc6b7e472ae72317";

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

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    odin-cli = {
      url = "git+ssh://git@github.com/cubbit/odin-cli";
      flake = false;
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
          ./pkgs
        ];

        flake = {
          darwinConfigurations = {
            invernomuto = self.nixos-flake.lib.mkMacosSystem {
              nixpkgs.hostPlatform = "x86_64-darwin";

              imports = [
                self.darwinModules.default # Defined in modules/darwin/default.nix
                ./hosts/invernomuto
              ];
            };
          };
        };
      };
}
