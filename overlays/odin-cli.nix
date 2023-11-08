{ odin-cli, ... }:

final: prev: {
  odin-cli = prev.callPackage "${odin-cli}" {};
}