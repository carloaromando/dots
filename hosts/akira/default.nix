{ config, modulesPath, pkgs, lib, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./lima-init.nix
  ];

  # ssh
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  users.users.root.password = "nixos";

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
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

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

  users.users.carlo = {
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    extraGroups = [
      "qemu-libvirtd"
      "libvirtd"
      "wheel"
      "disk"
      "networkmanager"
    ];
    home = "/home/carlo";
  };

  system.stateVersion = "23.05";
}
