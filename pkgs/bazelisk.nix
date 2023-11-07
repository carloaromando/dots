final: prev: {
  bazelisk = prev.bazelisk.overrideAttrs (_: {
    postInstall = ''
      ln -s $out/bin/bazelisk $out/bin/bazel
    '';
  });
}