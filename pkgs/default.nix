# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
final: prev: {
  emacscl = final.callPackage ./emacscl { };
  volume = final.callPackage ./volume { };
}
