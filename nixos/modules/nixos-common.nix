{
  lib,
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      autoconf
      automake
      bison
      file
      flex
      gnum4
      gnumake
      groff
      # inetutils # too old
      libgccjit
      # openssl
      # pinentry-all
      pkg-config
    ];
    wordlist = {
      enable = true;
    };
  };

  fonts = {
    enableDefaultPackages = false;
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Iosevka" "Sarasa Mono SC" ];
        sansSerif = [ "Sarasa Gothic SC" ];
        serif = [ "Sarasa Mono Slab SC" ];
      };
    };
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    packages = with pkgs; [
      amiri
      corefonts
      iosevka
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      sarasa-gothic
      source-han-sans
      source-han-serif
      symbola
    ];
  };
  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };
  networking = {
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
  };
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "@wheel"
      ];
    };
  };
  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableBrowserSocket = true;
        enableExtraSocket = true;
        enableSSHSupport = true;
        # settings = {
        #   default-cache-ttl = 3600;
        #   max-cache-ttl = 14400;
        # };
      };
    };
    less = {
      enable = true;
    };
  };
  security = {
    pam = {
      sshAgentAuth.enable = true;
      services.sudo.sshAgentAuth = true;
    };
    sudo = {
      wheelNeedsPassword = false;
    };
  };
  services = {
    keyd = {
      enable = true;
      keyboards.default.settings = {
        main = {
          capslock = "overload(control, esc)";
          esc = "capslock";
        };
      };
    };
    libinput = {
      enable = true;
    };
    logind = {
      extraConfig = ''
        HandlePowerKey=lock
      '';
    };
    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
      };
    };
    pipewire = {
      alsa.enable = true;
      enable = true;
      pulse.enable = true;
    };
  };
  users = {
    mutableUsers = false;
  };
}
