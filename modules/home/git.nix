{ pkgs, ... }:
let
  personalUserId = {
    user = {
      name = "carloaromando";
      email = "carlo.aromando@gmail.com";
    };
  };
in
{
  programs.git = {
    enable = true;
    includes = [
      {
        contents = personalUserId;
        condition = "gitdir:~/src/systems/";
      }
      {
        contents = personalUserId;
        condition = "gitdir:~/.password-store/";
      }
      {
        contents = {
          user = {
            name = "carlo-aromando";
            email = "carlo.aromando@cubbit.io";
            signingKey = "A941F87322270BFB";
          };
          commit.gpgSign = true;
          gpg.program = "${pkgs.gnupg}/bin/gpg";
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
