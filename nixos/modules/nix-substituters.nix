{
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cosmic.cachix.org/"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    ];
    trusted-public-keys = [
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
