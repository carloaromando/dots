{ self, ... }:
{
  flake = {
    homeModules = {
      base = {
        imports = [
          ./shell.nix
          ./direnv.nix
          ./zsh.nix
          ./git.nix
          ./ssh.nix
          ./bat.nix
          ./lf.nix
          ./micro.nix
        ];

        home.stateVersion = "22.11";

        programs.home-manager.enable = true;

        home.sessionVariables = {
          EDITOR = "micro";
          VISUAL = "$EDITOR";
          GPG_TTY = "$(tty)";
        };
      };

      default = {
        imports = [
          self.homeModules.base
          ./pkgs.nix
          ./pass.nix
          ./vscode.nix
          ./emacs
        ];

        home.sessionVariables = {
          GOPATH = "$HOME/.go/";
          BROWSER = "firefox";
        };
      };
    };
  };
}
