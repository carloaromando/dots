{ flake, pkgs, ... }:
{
  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
    overlays = [
      (import ../pkgs/bazelisk.nix)
      (import ../pkgs/odin-cli.nix { inherit (flake.inputs) odin-cli; })
    #   (import ../pkgs/coder.nix)
    ];
  };

  nix = {
    package = pkgs.nixUnstable;
    registry.nixpkgs.flake = flake.inputs.nixpkgs; # Make `nix shell` etc use pinned nixpkgs
    settings = {
      max-jobs = "auto";
      experimental-features = "nix-command flakes repl-flake";
      trusted-users = [ "root" "carlo" ];
    };
  };
}