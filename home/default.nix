{ self, ... }:
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
          ./pass.nix
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
        };
      };
    };
  };
}