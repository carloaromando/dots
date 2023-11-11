final: prev: {
  coder = prev.buildGoModule rec {
    inherit (prev.coder.drvAttrs)
      pname subPackages doCheck
      tags postInstall;

    version = "2.0.2";

    src = prev.fetchFromGitHub {
      owner = prev.coder.pname;
      repo = prev.coder.pname;
      rev = "v${version}";
      sha256 = "sha256-6XHgocfk82SU8AcCVSUFIYj1sD84V0P3koewXXrtBYw=";
    };

    pnpm-deps = prev.stdenvNoCC.mkDerivation {
      pname = "${pname}-pnpm-deps";
      inherit src version;

      nativeBuildInputs = [
        prev.jq
        prev.moreutils
        prev.nodePackages.pnpm
      ];

      installPhase = ''
        export HOME=$(mktemp -d)
        pnpm config set store-dir $out
        pushd site
        # use --ignore-script and --no-optional to avoid downloading binaries
        # use --frozen-lockfile to avoid checking git deps
        pnpm install --frozen-lockfile --no-optional --ignore-script --reporter append-only
        # Remove timestamp and sort the json files
        rm -rf $out/v3/tmp
        for f in $(find $out -name "*.json"); do
          sed -i -E -e 's/"checkedAt":[0-9]+,//g' $f
          jq --sort-keys . $f | sponge $f
        done
        popd
      '';

      dontBuild = true;
      dontFixup = true;
      outputHashMode = "recursive";
      outputHash = "sha256-feT/kNcuut+mEAW8+pTTnMMDYYkce6b2xabljKb0T+I=";
    };

    vendorHash = "sha256-ScP25MUVmsMhYRPTAsQwYkX2CA3G58qM2Ewk1zb2z4I=";

    ldflags = [
      "-s"
      "-w"
      "-X github.com/coder/coder/buildinfo.tag=${version}"
    ];

    preBuild = ''
      export HOME=$(mktemp -d)

      # Hack: permission error when running directly off `pnpm-deps`
      cp -r ${pnpm-deps} "$HOME/.pnmp-store"

      pushd site
      pnpm config set store-dir "$HOME/.pnmp-store"

      pnpm install --offline --frozen-lockfile --no-optional --ignore-script --reporter append-only

      pnpm typegen

      NODE_OPTIONS=--max-old-space-size=4096 pnpm build
      popd
    '';

    ESBUILD_BINARY_PATH = "${prev.lib.getExe (prev.esbuild.override {
    buildGoModule = args: prev.buildGoModule (args // rec {
      version = "0.18.17";
      src = prev.fetchFromGitHub {
        owner = "evanw";
        repo = "esbuild";
        rev = "v${version}";
        hash = "sha256-OnAOomKVUIBTEgHywDSSx+ggqUl/vn/R0JdjOb3lUho=";
      };
      vendorHash = "sha256-+BfxCyg0KkDQpHt/wycy/8CTG6YBA/VJvJFhhzUnSiQ=";
    });
  })}";

    nativeBuildInputs = [
      prev.installShellFiles
      prev.makeWrapper
      prev.nodePackages.node-pre-gyp
      prev.nodejs
      prev.pkg-config
      prev.python3
      prev.nodePackages.pnpm
    ];

    meta = prev.lib.attrsets.updateManyAttrsByPath [{
      path = [ "broken" ];
      update = old: false;
    }]
      prev.coder.meta;
  };
}
