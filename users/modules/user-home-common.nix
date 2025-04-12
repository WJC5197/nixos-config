{
  config,
  pkgs,
  ...
}:
{
  # mu init -m "mail"
  accounts.email.maildirBasePath = "${config.home.homeDirectory}/mail";
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
          (fcitx5-rime.override {
            rimeDataPkgs = with pkgs; [
              rime-data
              rime-ice
            ];
          })
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
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      enable = true;
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
    };
  };
}
