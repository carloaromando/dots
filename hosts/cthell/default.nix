{ config, modulesPath, pkgs, lib, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  # boot
  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "uhci_hcd"
    "ehci_pci"
    "ahci"
    "virtio_pci"
    "usbhid"
    "usb_storage"
    "sr_mod"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # filesystem
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/aeeeb939-bb42-44b9-af5a-c888ca69f154";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9B34-7BCF";
    fsType = "vfat";
  };

  # shared directory using nfs since i haven't find a proper way
  # to configure qemu shared dirs with utm
  fileSystems."/home/carlo/src" = {
    device = "192.168.64.1:/Users/carlo/src";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ]; # lazy mounting
  };

  swapDevices = [ ];

  # qemu
  # services.spice-vdagentd.enable = true;

  # ssh
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = true;

  users.users.root.initialPassword = "root";

  # don't require password for sudo
  security.sudo.wheelNeedsPassword = false;

  # virtualisation settings
  virtualisation.docker.enable = true;

  # user
  users.users.carlo = {
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" ];
    home = "/home/carlo";
  };

  # networking
  networking.useDHCP = false;
  networking.interfaces.enp0s1.useDHCP = true;
  networking.hostName = "cthell";
  networking.firewall.enable = false;

  # time
  time.timeZone = "Europe/Berlin";

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
