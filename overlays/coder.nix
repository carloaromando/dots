final: prev: {
  coder = prev.buildGoModule rec {
    inherit (prev.coder.drvAttrs)
      pname subPackages doCheck preBuild
      tags nativeBuildInputs postInstall;

    version = "0.17.4";

    src = prev.fetchFromGitHub {
      owner = prev.coder.pname;
      repo = prev.coder.pname;
      rev = "v${version}";
      sha256 = "sha256-WNHYWv9FIDbdBUeFC6hQ9l72mHBtKBGSdssnBho2N+A=";
    };

    offlineCache = prev.fetchYarnDeps {
      yarnLock = src + "/site/yarn.lock";
      hash = "sha256-fR/lJoALfRGlSGV503ayBSPBWlLmJC+3NyPd7I/2PJo=";
    };

    vendorHash = "sha256-J/rtcSgdZ7QL5hVmCybNbfUwhAkukheCLVZ7jeMt5bk=";

    ldflags = [
      "-s"
      "-w"
      "-X github.com/coder/coder/buildinfo.tag=${version}"
    ];
  };
}
