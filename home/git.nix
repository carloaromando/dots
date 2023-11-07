{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          user = {
            name = "carloaromando";
            email = "carlo.aromando@gmail.com";
          };
          signing = {
            key = "0";
            signByDefault = false;
            # gpgPath = "${pkgs.gnupg}";
            gpgPath = "/opt/local/bin/gpg";
          };
        };
        condition = "gitdir:~/dots/";
      }
      {
        contents = {
          user = {
            name = "carlo-aromando";
            email = "carlo.aromando@cubbit.io";
          };
          signing = {
            key = "A941F87322270BFB";
            signByDefault = true;
            # gpgPath = "${pkgs.gnupg}";
            gpgPath = "/opt/local/bin/gpg";
          };
        };
        condition = "gitdir:~/src/work/";
      }
    ];
    lfs.enable = true;
    aliases = {
      cm = "commit -m";
      di = "diff";
      pu = "pull";
      ps = "push";
      pf = "push -f";
      st = "status -sb";
      co = "checkout";
      nb = "checkout -b";
      fe = "fetch";
      rb = "rebase";
      ri = "rebase -i";
      cp = "cherry-pick";
      dev = "checkout develop";
      rsa = "restore .";
      rssa = "restore --staged .";
    };
    extraConfig = {
      core.editor = "micro";
      push = {
        default = "current";
        autoSetupRemote = true;
      };
    };
    ignores = [
      ".DS_Store"
    ];
  };
}