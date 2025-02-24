{
  emacs,
  lib,
  makeWrapper,
  stdenv,
}:
let
  # Import from lib.
  inherit (lib) makeBinPath;
in
stdenv.mkDerivation rec {
  buildInputs = [
    emacs
  ];
  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 emacscl.sh $out/bin/emacascl.sh
    wrapProgram $out/bin/emacscl.sh --prefix PATH : '${makeBinPath buildInputs}'
  '';
  name = "emacscl";
  nativeBuildInputs = [
    makeWrapper
  ];
  src = ./emacscl.sh;
  unpackCmd = ''
    mkdir src
    cp $curSrc src/emacscl.sh
  '';
}
