{ config, modulesPath, pkgs, lib, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./lima-init.nix
  ];

  # ssh
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  users.users.root = {
    shell = pkgs.zsh;
    initialHashedPassword = "";
  };

  users.users.carlo = {
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" ];
    home = "/home/carlo.linux";
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  # system mounts
  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  fileSystems."/boot" = {
    device = lib.mkForce "/dev/vda1"; # /dev/disk/by-label/ESP
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "discard" ];
  };

  # misc
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # pkgs
  environment.systemPackages = with pkgs; [
    git
    htop
    curl
    wget
    micro
    zsh
  ];

  programs.zsh.enable = true;

  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nixUnstable;
    settings = {
      max-jobs = "auto";
      experimental-features = "nix-command flakes repl-flake";
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

  system.stateVersion = "23.11";
}
