{
  gnupg,
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
    gnupg
  ];
  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 auth-get-pwd.sh $out/bin/auth-get-pwd.sh
    wrapProgram $out/bin/auth-get-pwd.sh --prefix PATH : '${makeBinPath buildInputs}'
  '';
  name = "auth-get-pwd";
  nativeBuildInputs = [
    makeWrapper
  ];
  src = ./auth-get-pwd.sh;
  unpackCmd = ''
    mkdir src
    cp $curSrc src/auth-get-pwd.sh
  '';
}
