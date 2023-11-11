{ pkgs, ... }:
let
  rubrication-theme = pkgs.callPackage ./rubrication-theme { inherit (pkgs.emacsPackages) trivialBuild; };
  rubricationThemePath = "${rubrication-theme}/share/emacs/site-lisp/rubrication-theme.el";
in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./emacs.el;
      defaultInitFile = pkgs.substituteAll {
        name = "default.el";
        src = ./emacs.el;
        inherit rubricationThemePath;
      };
      package = pkgs.emacs29-macport;
      alwaysEnsure = true;
      override = epkgs: epkgs // {
        inherit rubrication-theme;
      };
    };
  };
}
