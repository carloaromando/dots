{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bash
    gnupg
    pinentry
    ripgrep
    eza
    jq
    jo
    netcat
    nmap
    tshark
  ];
}
