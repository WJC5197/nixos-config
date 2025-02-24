# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
final: prev: {
  emacsclient = final.callPackage ./emacsclient { };
  volume = final.callPackage ./volume { };
}
