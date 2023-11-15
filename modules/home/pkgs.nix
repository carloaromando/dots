{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # shell
    pinentry_mac
    pv
    entr
    shell2http
    coreutils-prefixed
    websocat
    kcat

    # programming
    nil
    nixpkgs-fmt
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
