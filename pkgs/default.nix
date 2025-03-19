# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
final: prev: {
  auth-get-pwd = final.callPackage ./auth-get-pwd { };
  clash-for-windows = final.callPackage ./clash-for-windows { };
  # davinci-resolve-custom = final.callPackage ./davinci-resolve-custom { };
  emacsclient = final.callPackage ./emacsclient { };
  rime-ice = final.callPackage ./rime-ice { };
  spotify-custom = final.callPackage ./spotify-custom { };
  volume = final.callPackage ./volume { };
}
