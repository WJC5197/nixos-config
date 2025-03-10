# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
final: prev: {
  # davinci-resolve-custom = final.callPackage ./davinci-resolve-custom { };
  emacsclient = final.callPackage ./emacsclient { };
  spotify-custom = final.callPackage ./spotify-custom { };
  volume = final.callPackage ./volume { };
}
