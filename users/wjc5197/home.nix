{
  dpi,
}:
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  accounts = {
    email.accounts.wjc5197 = {
      address = "wjc5197@gmail.com";
      flavor = "gmail.com";
      gpg = {
        key = "28ED85EC47C3E1A84FA9A52B5F919C9DB9BADDD4";
        signByDefault = true;
      };
      imap = {
        host = "imap.gmail.com";
      };
      mbsync = {
        enable = true;
      };
      msmtp = {
        enable = true;
      };
      mu = {
        enable = true;
      };
      passwordCommand = "gpg -d -q ~/.secrets/gmail-imap.gpg";
      primary = true;
      realName = "WJC5197";
      userName = "wjc5197@gmail.com";
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/sound" = {
        event-sounds = false;
      };
    };
  };

  gtk = {
    enable = true;
    font = {
      name = "Iosevka";
      # size = 10;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  home = {
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
      ".authinfo.gpg".source = ./secrets/authinfo.gpg;
      ".ideavimrc".source = ./ideavimrc;
      ".m2/settings.xml".source = ./mvn.xml;
      ".rsync".source = ./rsync;
      ".secrets".source = ./secrets;
      ".xmonad/lib".source = ./xmonad/lib;
      ".xmonad/xmonad.hs".source = ./xmonad/xmonad.hs;
    };
    homeDirectory = "/home/wjc5197";
    packages = with pkgs; [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello
      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')

      # archivebox # insecure
      agda
      aider-chat
      anki-bin
      (aspellWithDicts (
        dicts: with dicts; [
          en
          en-computers
          en-science
        ]
      ))
      audacity
      bear
      betterlockscreen
      bleachbit
      blender
      blueman
      cabal-install
      cachix
      ccache
      # clash-verge-rev
      clang
      clang-tools
      clipmenu
      clojure
      clojure-lsp
      cmake
      code-cursor
      dbeaver-bin
      dconf
      deno
      discord
      # dmd
      dotnet-sdk
      dunst
      espeak
      evtest
      ffmpeg-full
      firejail
      fontforge
      gh
      ghc
      ghostscript
      gimp
      glew
      glfw
      # glib
      goldendict-ng
      # google-cloud-sdk
      gopls
      gparted
      gperf
      # gping
      gradle
      graphviz
      gsl
      gtest
      guile
      # haskellPackages.ghcup
      haskell-language-server
      hledger
      hledger-web
      html-tidy
      imagemagick
      inkscape
      jdt-language-server
      jetbrains.idea-community-bin
      jq
      kdePackages.full
      # kdePackages.okular
      krita
      leiningen
      libllvm
      libreoffice-fresh
      # libsForQt5.full
      # lldb
      # llvmPackages.libcxx
      # llvmPackages.libcxxClang
      # mariadb
      # mesa
      maven
      meson
      metals
      moonlight-qt
      musescore
      nil
      ninja
      nodejs
      nyxt
      onboard
      onedrive
      # openai-whisper-cpp
      plantuml
      python3
      ra-multiplex
      racket-minimal
      rclone
      redshift
      rsync
      ruff-lsp # python lsp
      # rustlings
      rustup
      # rust-analyzer
      sbcl
      scala
      scrcpy
      screenkey
      scrot
      SDL2
      shotcut
      solaar
      speedtest-cli
      styluslabs-write
      tailscale
      tailwindcss
      # tdlib
      tokei
      tor-browser
      translate-shell
      typescript
      typescript-language-server
      typst
      unrar
      # volume
      w3m
      wineWowPackages.full
      wolfram-engine
      # xautolock
      xdg-ninja
      xmake
      xss-lock
      # yq
      zeal
      zig
      zls
      zotero
    ];

    pointerCursor = {
      gtk.enable = true;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      # size = 51;
      x11.enable = true;
    };
    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/roam/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      CM_HISTLENGTH = 31;
      CM_LAUNCHER = "rofi";
      TERMINAL = "kitty";
    };
    stateVersion = "24.11"; # Please read the comment before changing.
    username = "wjc5197";
  };

  imports = [
    ../modules/user-home-common.nix
  ];

  programs = {
    aria2 = {
      enable = true;
    };
    bun = {
      enable = true;
    };
    emacs = {
      enable = true;
      package = pkgs.emacs30;
      extraPackages = epkgs: [
        # pkgs.emacsPackages.jinx
        # pkgs.emacsPackages.rime
        # pkgs.librime
        # epkgs.tdlib
        epkgs.mu4e
        epkgs.pdf-tools
        epkgs.telega
        epkgs.vterm
        # epkgs.w3m
      ];
    };
    feh = {
      enable = true;
    };
    firefox = {
      enable = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      userEmail = "wjc5197@gmail.com";
      userName = "wjc5197";
    };
    go = {
      enable = true;
    };
    helix = {
      enable = true;
    };
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    java = {
      enable = true;
    };
    kitty = {
      enable = true;
      settings = {
        enable_audio_bell = false;
      };
      extraConfig = builtins.readFile ./kitty.conf;
    };
    mbsync = {
      enable = true;
    };
    mpv = {
      enable = true;
    };
    msmtp = {
      enable = true;
    };
    mu = {
      enable = true;
    };
    neovim = {
      enable = true;
    };
    obs-studio = {
      enable = true;
    };
    # opam = {
    #   enable = true;
    #   enableBashIntegration = true;
    #   enableZshIntegration = true;
    # };
    pandoc = {
      enable = true;
    };
    rofi = {
      cycle = true;
      enable = true;
      font = "Iosevka ${builtins.toString (builtins.floor (10 * dpi / 72))}";
      extraConfig = {
        modes = "drun";
        show-icons = true;
      };
      theme = ./rofi.rasi;
    };
    texlive = {
      enable = true;
      extraPackages = tpkgs: {
        inherit (tpkgs)
          amsmath
          capt-of
          dvipng # for preview and export as html
          dvisvgm
          hyperref
          mylatexformat
          scheme-basic
          ulem
          wrapfig
          ;
      };
    };
    tmux = {
      enable = true;
    };
    vscode = {
      enable = true;
    };
    xmobar = {
      enable = true;
      extraConfig = builtins.replaceStrings [ "dpi = 96" ] [ "dpi = ${toString dpi}" ] (
        builtins.readFile ./xmobarrc
      );
    };
    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    zsh = {
      autosuggestion = {
        enable = true;
      };
      defaultKeymap = "emacs";
      enable = true;
      enableCompletion = true;
      initExtra = builtins.readFile ./zshrc;
      history = {
        size = 10000000;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "fzf"
          "git"
          "man"
        ];
        # theme = "lambda";
      };
      syntaxHighlighting = {
        enable = true;
      };
    };
  };

  # qt = {
  #   enable = true;
  #   platformTheme = {
  #     name = "gnome";
  #   };
  #   style = {
  #     name = "adwaita-dark";
  #     package = pkgs.adwaita-qt;
  #   };
  # };

  wayland = {
    windowManager = {
      sway = {
        enable = true;
        config = rec {
          keybindings = lib.mkOptionDefault {
            # "${modifier}+Shift+c" = "kill";
          };
          modifier = "Mod4";
          # Use kitty as default terminal
          terminal = "kitty";
          startup = [
            # { command = "firefox"; }
          ];
        };
      };
    };
  };

  xdg = {
    configFile = {
      "dunst/dunstrc".source = ./dunstrc;
      "redshift/redshift.conf".source = ./redshift.conf;
      # "sway/config".source = pkgs.lib.mkOverride 10 "/home/<user>/dotfiles/sway/config"
    };
    # desktopEntries = {
    #   mupdf = {
    #     name = "Mupdf";
    #     genericName = "Web Browser";
    #     exec = "mupdf-x11 %f";
    #     terminal = false;
    #     categories = [
    #       "Application"
    #     ];
    #     mimeType = [
    #       "application/pdf"
    #     ];
    #   };
    # };
  };

  xresources = {
    properties = {
      "Xft.antialias" = 1;
      "Xft.dpi" = dpi;
      "Xft.hinting" = 1;
      "Xft.hintstyle" = "hintfull";
      "Xft.rgba" = "rgb";
    };
  };

  # xsession = {
  #   enable = true;
  #   windowManager = {
  #     xmonad = {
  #       enable = true;
  #       enableContribAndExtras = true;
  #     };
  #   };
  # };
}
