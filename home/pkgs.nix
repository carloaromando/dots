{ pkgs, ... }:
{
  home.packages =  with pkgs; [
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
    bash
    ninja
    clang-tools_12
    bazelisk
    bazel-buildtools
    python3
    poetry
    pylint
    black
    tilt
    nodejs
    yarn
    shellcheck
    odin-cli
    go-task
    act
    awscli2
    go
    coder

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