{
  dunst,
  lib,
  makeWrapper,
  pipewire,
  stdenv,
}:
let
  # Import from lib.
  inherit (lib) makeBinPath;
in
stdenv.mkDerivation rec {
  buildInputs = [
    dunst
    pipewire
  ];
  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 volume.sh $out/bin/volume.sh
    wrapProgram $out/bin/volume.sh --prefix PATH : '${makeBinPath buildInputs}'
  '';
  name = "volume";
  nativeBuildInputs = [
    makeWrapper
  ];
  src = ./volume.sh;
  unpackCmd = ''
    mkdir src
    cp $curSrc src/volume.sh
  '';
}
