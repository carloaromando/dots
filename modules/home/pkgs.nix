{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # shell
    pinentry_mac # TODO move to macos only file
    pv
    entr
    coreutils-prefixed
    rlwrap

    # networking
    iperf
    websocat
    kcat
    shell2http
    tailscale
    lagrange

    # programming
    bazelisk

    ## ninja
    ninja

    ## nix 
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
    ansible

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
    localsend
    mupdf
  ] ++ (with nixcasks; [
    iina
    vlc
    alfred
    # utm
  ]);
}
