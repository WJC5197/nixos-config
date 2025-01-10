{
  pkgs,
  ...
}:
{
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Sans Emoji" ];
        monospace = [ "Iosevka" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
      };
    };
  };
  home = {
    packages = with pkgs; [
    ];
    sessionVariables = {
      EDITOR = "nvim";
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
  };
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-rime
          fcitx5-chinese-addons
          fcitx5-with-addons
          fcitx5-configtool
          fcitx5-gtk
          kdePackages.fcitx5-qt
        ];
      };
    };
  };
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
    };
  };
}
