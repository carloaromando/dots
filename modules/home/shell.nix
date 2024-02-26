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
    mg
  ];

  home.sessionVariables = {
    EDITOR = "mg";
    VISUAL = "$EDITOR";
    GPG_TTY = "$(tty)";
  };

  home.shellAliases = {
    nixactivate = "pushd $HOME/src/systems; nix run .#activate; popd";
    nixup = "pushd $HOME/src/systems; nix run .#update; popd";
    nixgc = "nix store gc --debug";
    g = "${pkgs.lib.getExe pkgs.git}";
    ls = "${pkgs.lib.getExe pkgs.eza}";
    l = "ls";
    ll = "ls -la --group-directories-first";
    llt = "ll --tree";
    lt = "ls --tree";
    clr = "clear";
    rgf = "${pkgs.lib.getExe pkgs.ripgrep} --files | ${pkgs.lib.getExe pkgs.ripgrep}";
  };
}
