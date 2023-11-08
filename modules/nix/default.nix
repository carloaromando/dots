{
  flake = {
    nixosModules = {
      # NixOS modules that are known to work on nix-darwin.
      common.imports = [
        ./nix.nix
      ];
    };
  };
}
