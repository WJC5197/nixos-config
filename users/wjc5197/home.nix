{
  config,
  dpi,
  inputs,
  lib,
  pkgs,
  # system,
  ...
}:

let
  system = pkgs.system;
in
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
    email = {
      accounts.wjc5197 = {
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
        passwordCommand = "auth-get-pwd.sh 'imap.gmail.com' 'WJC5197@gmail.com'";
        primary = true;
        realName = "WJC5197";
        userName = "wjc5197@gmail.com";
      };
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
      # ".blog/placeholder".source = ./placeholder;
      ".ideavimrc".source = ./ideavimrc;
      ".m2/settings.xml".source = ./mvn.xml;
      ".npmrc".source = ./npmrc;
      ".rsync".source = ./rsync;
      ".secrets".source = ./secrets;
      ".wallpapers".source = ./wallpapers;
      ".xmonad/lib".source = ./xmonad/lib;
      ".xmonad/xmonad.hs".source = ./xmonad/xmonad.hs;
      ".zotero/zotero/profiles.ini".source = ./zotero/profiles.ini;
      ".zotero/zotero/wjc5197/user.js".source = ./zotero/user.js;
    };
    homeDirectory = "/home/wjc5197";
    packages =
      with pkgs;
      [
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

        agda
        aider-chat
        airshipper
        anki-bin
        # archivebox # insecure
        (aspellWithDicts (
          dicts: with dicts; [
            en
            en-computers
            en-science
          ]
        ))
        audacity
        auth-get-pwd
        bear
        betterlockscreen
        bleachbit
        blender
        blueman
        # cabal-install
        cachix
        caddy
        ccache
        clang
        clang-tools
        # clash-nyanpasu
        # clash-verge-rev
        clipmenu
        clojure
        clojure-lsp
        # cmake # set cmake as nativeBuildInputs in project
        code-cursor
        dbeaver-bin
        dconf
        deno
        discord
        # dmd
        dotnet-sdk
        dunst
        emacsclient
        emanote
        espeak
        evtest
        ffmpeg-full
        firejail
        fontforge
        freecad
        ghc
        ghostscript
        gimp
        glew
        glfw
        # glib
        gnuapl
        gnuplot
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
        gtkwave
        guile
        # haskellPackages.ghcup
        haskell-language-server
        hledger
        hledger-web
        html-tidy
        http-server
        hugo
        imagemagick
        inkscape
        jdt-language-server
        # joplin-desktop
        jq
        julia
        just
        kdePackages.full
        # kdePackages.okular
        kicad
        krita
        leiningen
        libllvm
        libreoffice-fresh
        # libsForQt5.full
        # livecaptions
        # lldb
        # llvmPackages.libcxx
        # llvmPackages.libcxxClang
        lmms
        lua-language-server
        luanti
        # mariadb
        maven
        # mesa
        meson
        metals
        mkcert
        monolith
        moonlight-qt
        musescore
        nil
        ninja
        nodejs
        nyxt
        onboard
        onedrive
        # openai-whisper-cpp
        opera
        ormolu
        plantuml
        prismlauncher
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
        scalafmt
        scrcpy
        screenkey
        scrot
        shotcut
        showmethekey
        sigil
        signal-cli
        solaar
        speedtest-cli
        sql-formatter
        spotify-custom
        # sqls
        stylua
        styluslabs-write
        # subtitleedit
        tailscale
        tailwindcss
        # tdlib
        termshark
        thefuck
        tinymist
        tldr
        tokei
        tor-browser
        translate-shell
        typescript
        typescript-language-server
        typst
        typstyle
        unrar
        verilator
        # volume
        w3m
        wineWowPackages.full
        wolfram-engine
        # xautolock
        xdg-ninja
        xmake
        xss-lock
        # yamlfmt
        # yq
        z3
        zeal
        zig
        zls
        zotero
      ]
      ++ (with pkgs.jetbrains; [
        idea-community-bin
        rust-rover
      ])
      ++ (with pkgs.nodePackages; [
        prettier
      ])
      # specific architecture pkgs, mostly custom pkgs
      ++ lib.optionals (system == "x86_64-linux") (
        with pkgs;
        [
          clash-for-windows
          # lceda-pro
        ]
      );

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
      DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
      # MUHOME = "${config.home.homeDirectory}/maildir";
      TERMINAL = "kitty";
    };
    stateVersion = "24.11"; # Please read the comment before changing.
    username = "wjc5197";
  };

  imports = [
    ../modules/lazyvim.nix
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
      package = pkgs.emacs-git;
      # xwidget webkitgtk upstream is flawed
      # package = (pkgs.emacs-git.override {
      #   withGTK3 = true;
      #   withImageMagick = true;
      #   withXwidgets = true;
      # });
      extraPackages =
        epkgs: with epkgs; [
          # pkgs.emacsPackages.jinx
          # pkgs.emacsPackages.rime
          # pkgs.librime
          # epkgs.tdlib
          copilot
          # epkgs.ement
          mu4e
          pdf-tools
          telega
          treesit-grammars.with-all-grammars
          vterm
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
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      extraConfig = {
        # although gh as credential helper by default, netrc can be used in non github repo
        credential.helper = "netrc";
        color = {
          ui = "auto";
        };
        init = {
          defaultBranch = "main";
        };
        log = {
          abbrevCommit = true;
          follow = true;
        };
        pull = {
          rebase = true;
        };
        push = {
          autoSetupRemote = true;
          default = "simple";
          followTags = true;
        };
        tag = {
          sort = "version:refname";
        };
      };
      userEmail = "wjc5197@gmail.com";
      userName = "wjc5197";
    };
    gh = {
      enable = true;
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
    lazygit = {
      enable = true;
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
          scheme-full
          ;
      };
    };
    tmux = {
      enable = true;
    };
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
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
      enableFishIntegration = true;
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
    # ~/.config
    configFile = {
      "dunst/dunstrc".source = ./dunstrc;
      "fcitx/rime/default.custom.yaml".source = ./rime.yaml;
      "fcitx5/conf/clipboard.conf".source = ./fcitx5-clipboard.conf;
      "nvim/lua".source = ./nvim;
      "redshift/redshift.conf".source = ./redshift.conf;
      # "sway/config".source = pkgs.lib.mkOverride 10 "/home/<user>/dotfiles/sway/config"
      "Zeal/Zeal.conf".source = ./zeal.conf;
    };
    # ~/.local/share
    dataFile = {
      "fcitx5/rime/default.custom.yaml".source = ./rime.yaml;
    };
    desktopEntries = {
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
      emacsclient-mail = {
        categories = [
          "Network"
          "Email"
        ];
        comment = "GNU Emacs is an extensible, customizable text editor - and more";
        exec = "${pkgs.emacsclient}/bin/emacsclient.sh %u";
        genericName = "Text Editor";
        icon = "emacs";
        name = "Emacs (Mail)";
        mimeType = [ "x-scheme-handler/mailto" ];
        noDisplay = true;
        terminal = false;
        type = "Application";
      };
    };
    mimeApps = {
      defaultApplications = {
        "application/pdf" = [ "mupdf.desktop" ];
        "inode/directory" = [ "yazi.desktop" ];
        "text/html" = [ "google-chrome.desktop" ];
        "x-scheme-handler/about" = [ "google-chrome.desktop" ];
        "x-scheme-handler/http" = [ "google-chrome.desktop" ];
        "x-scheme-handler/https" = [ "google-chrome.desktop" ];
        "x-scheme-handler/mailto" = [ "emacsclient-mail.desktop" ];
        "x-scheme-handler/unknown" = [ "google-chrome.desktop" ];
      };
      enable = true;
    };
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
