{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # shell
    gnupg
    htop
    ripgrep
    comma
    duf
    eza
    jq
    jo
    pv
    entr
    shell2http

    # networking
    curl
    netcat
    nmap
    websocat
    kcat
    tshark

    # programming
    nil
    nixpkgs-fmt
    bash
    ninja
    python3
    poetry
    pylint
    black
    nodejs
    yarn
    shellcheck
    odin-cli
    act
    awscli2
    go
    coder
    minio-client

    # virtualization
    qemu
    lima

    # container
    docker
    kubernetes-helm
    kubectl
    k9s

    # media
    ffmpeg_5
    yt-dlp

    # broken
    ## handbrake
    ## goofys
  ];
}