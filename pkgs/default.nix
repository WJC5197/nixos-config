# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
final: prev: {
  auth-get-pwd = final.callPackage ./auth-get-pwd { };
  clash-for-windows = final.callPackage ./clash-for-windows { };
  # davinci-resolve-custom = final.callPackage ./davinci-resolve-custom { };
  emacsclient = final.callPackage ./emacsclient { };
  lceda-pro = final.callPackage ./lceda-pro { };
  monolisa = final.callPackage ./monolisa { };
  rime-ice = final.callPackage ./rime-ice { };
  sf-pro = final.callPackage ./sf-pro { };
  spotify-custom = final.callPackage ./spotify-custom { };
  volume = final.callPackage ./volume { };
}
