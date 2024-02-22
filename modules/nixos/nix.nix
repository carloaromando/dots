{ flake, pkgs, ... }:
{
  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
    overlays = [
      flake.inputs.emacs-overlay.overlays.default
      (import ../../overlays/bazelisk.nix)
      (import ../../overlays/coder.nix { inherit (flake.inputs) nixpkgs-old; })
    ];
  };

  nix = {
    package = pkgs.nixUnstable;
    registry.nixpkgs.flake = flake.inputs.nixpkgs; # Make `nix shell` etc use pinned nixpkgs
    nixPath = [
      "nixpkgs=${flake.inputs.nixpkgs}"
      "nix-darwin=${flake.inputs.nix-darwin}"
      "home-manager=${flake.inputs.home-manager}"
    ];
    settings = {
      max-jobs = "auto";
      experimental-features = "nix-command flakes repl-flake";
      trusted-users = [ "root" "carlo" ];
    };
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = pkgs.lib.mkDefault true;
      options = pkgs.lib.mkDefault "--delete-older-than 1w";
    };
  };
}
