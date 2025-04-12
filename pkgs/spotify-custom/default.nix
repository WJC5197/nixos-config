# https://github.com/oskardotglobal/.dotfiles/blob/nix/overlays/spotx.nix
{ pkgs, ... }:
let
  spotx = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/21481cea97bac720590c2aad8b1fc2c58c9ec8f9/spotx.sh";
    hash = "sha256-1k1sEEnT1SE6RAWrfd1qFY1gFrUVNh7zUQJLu3DODlU=";
  };
in
pkgs.spotify.overrideAttrs (old: {
  nativeBuildInputs =
    old.nativeBuildInputs
    ++ (with pkgs; [
      util-linux
      perl
      unzip
      zip
      curl
    ]);

  unpackPhase =
    builtins.replaceStrings
      [ "runHook postUnpack" ]
      [
        ''
          patchShebangs --build ${spotx}
          runHook postUnpack
        ''
      ]
      old.unpackPhase;

  installPhase =
    builtins.replaceStrings
      [ "runHook postInstall" ]
      [
        ''
          bash ${spotx} -f -P "$out/share/spotify"
          runHook postInstall
        ''
      ]
      old.installPhase;
})
