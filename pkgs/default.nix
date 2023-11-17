{ inputs, withSystem, ... }:
{
  flake = {
    packages.x86_64-linux.mkAkiraImg = withSystem "x86_64-linux"
      (ctx@{ inputs', pkgs, ... }:
        let
          homeModule = {
            imports = [
              ../modules/home/shell.nix
              ../modules/home/direnv.nix
              ../modules/home/zsh.nix
              ../modules/home/git.nix
              ../modules/home/ssh.nix
              ../modules/home/bat.nix
              ../modules/home/lf.nix
              ../modules/home/micro.nix
            ];

            home.stateVersion = "22.11";

            programs.home-manager.enable = true;

            home.sessionVariables = {
              EDITOR = "micro";
              VISUAL = "$EDITOR";
              GPG_TTY = "$(tty)";
            };
          };

          nixosModule = {
            imports = [
              inputs.home-manager.nixosModules.home-manager
              ({
                home-manager.users.carlo = { pkgs, ... }: {
                  imports = [
                    homeModule
                  ];
                };
              })
            ];
          };
        in
        inputs.nixos-generators.nixosGenerate {
          inherit pkgs;

          modules = [
            ../hosts/akira
          ];

          format = "raw-efi";
        }
      );
  };
}
