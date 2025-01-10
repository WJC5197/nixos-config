{
  efiSysMountPoint,
  customResolution ? null,
  theme
}:
{
  inputs,
  ...
}:
{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        inherit efiSysMountPoint;
      };
      grub = {
        device = "nodev";
        efiSupport = true;
        # font = "${pkgs.iosevka}/share/fonts/truetype/Iosevka-Regular.ttf";
        # fontSize = 31;
        # gfxmodeEfi = "2880x1920";
        useOSProber = true;
      };
      grub2-theme = {
        enable = true;
        footer = true;
        inherit customResolution theme;
      };
    };
  };
  imports = [
    inputs.grub2-themes.nixosModules.default
  ];
}
