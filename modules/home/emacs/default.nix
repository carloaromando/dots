{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./.emacs.d/init.el;
      defaultInitFile = true;
      alwaysEnsure = true;
      package = pkgs.emacs29-macport;
    };
  };

  home.file.".emacs.d" = {
    source = ./.emacs.d;
    recursive = true;
  };
}
