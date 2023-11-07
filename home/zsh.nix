{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    completionInit = "autoload -U compinit -u && compinit -u";
    dirHashes = {
      cubbit = "$HOME/src/work/cubbit";
      work = "$HOME/src/work";
      learn = "$HOME/src/learn";
      projects = "$HOME/src/projects";
      scripts = "$HOME/src/scripts";
      hack = "$HOME/src/hack";
    };
    shellAliases = {
      nixswitch = "darwin-rebuild switch --flake $HOME/dots/.#";
      nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
      nixcollect = "nix-collect-garbage";
      g = "${lib.getExe pkgs.git}";
      ls = "${lib.getExe pkgs.eza}";
      l = "ls";
      ll = "ls -la --group-directories-first";
      llt = "ll --tree";
      lt = "ls --tree";
      clr = "clear";
      tup = "${lib.getExe pkgs.tilt} -f ~cubbit/coordinator/Tiltfile up";
      tdown = "${pkgs.tilt} -f ~cubbit/coordinator/Tiltfile down";
      rgf = "${lib.getExe pkgs.ripgrep} --files | ${lib.getExe pkgs.ripgrep}";
    };
    plugins = [
      {
        name = "zsh-autocomplete";
        file = "zsh-autocomplete.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "d00142dd752c15aaa775d79c61ff0611acf20bad";
          sha256 = "sha256-0yzqbX39hqsE2mAXFY3uoK5zrcm0uZmsTr+dB8keFIs=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
      {
        name = "minimal";
        file = "minimal.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "subnixr";
          repo = "minimal";
          rev = "9dd104f1bddbf742ced6e1e31b14e2b394a47690";
          sha256 = "sha256-/Sn1h0lMj81u9v2+mQ4HACjhcaydk9YsOnlYAkQFcBg=";
        };
      }
    ];
    initExtraFirst = ''
      function nix_shell_prompt
      {
        if [[ -v IN_NIX_SHELL ]]; then
          print "%B[nix shell]%b"
        fi
      }
    '';
    initExtra = ''
      MNML_INFOLN=()
      MNML_MAGICENTER=()
      MNML_RPROMPT=(nix_shell_prompt $MNML_RPROMPT);
    '';
    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      ZSH_DISABLE_COMPFIX = "true";
    };
  };
}