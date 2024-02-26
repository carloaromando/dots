{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # shell
    pinentry_mac # TODO move to macos only file
    pv
    entr
    shell2http
    coreutils-prefixed
    websocat
    kcat
    rlwrap

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
    # utm [Permission denied error when starting a new VM] 

    # container
    docker
    kubernetes-helm
    kubectl
    kubectx
    k9s

    # media
    ffmpeg_5
    yt-dlp
  ] ++ (with nixcasks; [
    iina
    vlc
    alfred
    # utm
  ]);
}
