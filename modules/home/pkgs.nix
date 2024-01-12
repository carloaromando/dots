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

    ## ninja
    ninja

    ## nix 
    nil
    nixpkgs-fmt

    ## python
    python3
    poetry
    pylint
    black

    ## js
    nodejs
    yarn

    ## shell
    shellcheck

    ## go
    go

    ## misc
    awscli2
    minio-client
    coder

    # virtualization
    qemu
    lima

    # container
    docker
    kubernetes-helm
    kubectl
    kubectx
    k9s

    # media
    ffmpeg_5
    yt-dlp

    # broken
    ## handbrake
    ## goofys
    ## odin-cli
  ];
}
