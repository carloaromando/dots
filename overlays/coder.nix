{ nixpkgs-old, ... }:

final: prev: {
  coder = nixpkgs-old.legacyPackages.${prev.system}.coder;
}
