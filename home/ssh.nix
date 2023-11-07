{ pkgs, lib, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "yocto-vm" = {
        user = "yocto";
        hostname = "localhost";
        port = 22022;
      };
      "cubbit-cell" = {
        user = "root";
        hostname = "192.168.1.108";
      };
      "cubbit-bh" = {
        hostname = "bh.cubbit.eu";
        user = "ubuntu";
        localForwards = [{
          bind.port = 5432;
          host.address = "cubbit-db.cfhojsg4cdow.eu-west-1.rds.amazonaws.com";
          host.port = 5432;
        }];
        identityFile = "/Users/carlo/.ssh/id_rsa";
      };
      "cubbit-network" = {
        hostname = "network.cubbit.dev";
        user = "ubuntu";
        identityFile = "/Users/carlo/.ssh/id_rsa";
      };
      "cubbit-coder" = {
        hostname = "coder.cubbit";
        proxyCommand = "${lib.getExe pkgs.coder} --global-config \"/Users/carlo/Library/Application Support/coderv2\" ssh --stdio cubbit";
        extraOptions = {
          connectTimeout = "0";
          userKnownHostsFile = "/dev/null";
          strictHostKeyChecking = "no";
          logLevel = "ERROR";
        };
      };
    };
  };
}