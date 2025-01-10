{
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      wayland-utils
    ];
  };

  i18n = {
    inputMethod = {
      fcitx5 = {
        plasma6Support = true;
        waylandFrontend = true;
      };
      type = "fcitx5";
    };
  };

  imports = [
    ./modules/nixos-common.nix
  ];

  services = {
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
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
