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
  name = "volume";
  # disable unpackPhase etc
  # phases = "buildPhase";
  src = ./volume.sh;
  nativeBuildInputs = [
    makeWrapper
  ];
  buildInputs = [
    dunst
    pipewire
  ];
  unpackCmd = ''
    mkdir src
    cp $curSrc src/volume.sh
  '';
  # PATH = lib.makeBinPath nativeBuildInputs;
  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 volume.sh $out/bin/volume.sh
    wrapProgram $out/bin/volume.sh --prefix PATH : '${makeBinPath buildInputs}'
  '';
}
