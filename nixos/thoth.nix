{
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      wayland-utils
      # remember to use wayland clipboard
      xsel
    ];
  };
  imports = [
    ./modules/fish
    ./modules/nixos-common.nix
  ];
  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };

  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
      };
    };
  };
  system.stateVersion = "24.11"; # Did you read the comment?
}
