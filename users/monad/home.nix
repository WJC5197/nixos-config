{
  dpi,
  pkgs,
  ...
}:
{
  home = {
    homeDirectory = "/home/monad";
    stateVersion = "24.11"; # Please read the comment before changing.
    username = "monad";
  };
  imports = [
    ../modules/user-home-common.nix
  ];
}
