{
  lib,
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      btop
      clash-meta
      fastfetch
      fd
      file
      gnumake
      google-chrome
      libgccjit
      nixfmt-rfc-style
      openssl
      p7zip
      ripgrep
      tree
      wget
      unzip
    ];
  };
  fonts = {
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    enableDefaultPackages = false;
    packages = with pkgs; [
      iosevka
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-emoji
      sarasa-gothic
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
    git = {
      enable = true;
    };
    gnupg = {
      agent = {
        enable = true;
        enableBrowserSocket = true;
        enableExtraSocket = true;
        enableSSHSupport = true;
      };
    };
    less = {
      enable = true;
    };
    neovim = {
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
          capslock = "esc";
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
