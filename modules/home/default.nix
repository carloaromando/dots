{
  flake = {
    homeModules = {
      common = {
        imports = [
          ./direnv.nix
          ./pkgs.nix
          ./zsh.nix
          ./git.nix
          ./ssh.nix
          ./bat.nix
          ./lf.nix
          ./micro.nix
          ./pass.nix
          ./vscode.nix
          ./emacs
        ];

        home.stateVersion = "22.11";

        programs.home-manager.enable = true;
        programs.micro.enable = true;
        programs.bat.enable = true;
        programs.lf.enable = true;

        home.sessionVariables = {
          EDITOR = "micro";
          VISUAL = "$EDITOR";
          GPG_TTY = "$(tty)";
          GOPATH = "$HOME/.go/";
          BROWSER = "firefox";
          TERMINAL = "kitty";
        };
      };
    };
  };
}
