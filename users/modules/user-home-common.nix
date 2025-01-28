{
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      brightnessctl
      btop
      fastfetch
      fd
      gdb
      google-chrome
      mupdf
      nixfmt-rfc-style
      p7zip
      ripgrep
      tree
      # wget
      unzip
      volume
      xdg-utils
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
  programs = {
    feh = {
      enable = true;  
    };
    git = {
      delta = {
        enable = true;  
      };
      enable = true;
    };
    mpv = {
      enable = true;  
    };
    neovim = {
      enable = true;
    };
  };
  xdg = {
    enable = true;
    # portal = {
    #   enable = true;  
    # };
    userDirs = {
      enable = true;
    };
  };
}
