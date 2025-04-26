{
  lib,
  pkgs,
  ...
}:

{
  documentation = {
    dev = {
      enable = true;
    };
    enable = true;
    man = {
      generateCaches = false;
      man-db.enable = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      bpftrace
      docker-compose
      lazydocker
      linuxHeaders
      linux-manual
      lm_sensors
      man-pages
      man-pages-posix
      wayland-utils
      vulkan-tools
      xsel
    ];
  };

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      lxgw-wenkai
      maple-mono-NF
      monolisa
      sf-pro
    ];
  };

  imports = [
    ./modules/nixos-common.nix
    ./modules/zsh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
    nix-ld = {
      enable = true;
    };
    steam = {
      enable = true;
    };
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    virt-manager = {
      enable = true;
    };
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  services = {
    acpid = {
      enable = true;
      logEvents = true;
    };
    apache-kafka = {
      enable = true;
      settings = {
        "log.dirs" = [ "/var/lib/apache-kafka" ];
        "zookeeper.connect" = "localhost:2181";
      };
    };
    # aria2 = {
    #   enable = true;
    #   rpcSecretFile = /run/secrets/aria2-rpc-token.txt;
    # };
    # service caddy doesn't provide binary
    # caddy = {
    #   enable = true;
    # };
    clamav = {
      daemon.enable = true;
      updater = {
        enable = true;
        frequency = 3;
        interval = "weekly";
      };
    };
    cloudflare-warp = {
      enable = true;
    };
    displayManager = {
      ly = {
        enable = true;
        settings = {
          animation = "matrix";
        };
      };
    };
    distccd = {
      enable = true;
    };
    elasticsearch = {
      enable = true;
    };
    fwupd = {
      enable = true;
    };
    geth = {
      logos = {
        enable = true;
      };
    };
    guix = {
      enable = true;
    };
    jenkins = {
      enable = true;
    };
    k3s = {
      enable = true;
    };
    # nginx = {
    #   enable = true;
    # };
    mysql = {
      enable = true;
      package = pkgs.mariadb;
      settings = {
        client = {
          default-character-set = "utf8mb4";
        };
        mysqld = {
          character-set-server = "utf8mb4";
          collation-server = "utf8mb4_general_ci";
        };
      };
    };
    ollama = {
      enable = true;
    };
    # picom = {
    #   enable = true;
    # };
    postgresql = {
      enable = true;
    };
    # Enable CUPS to print documents.
    printing = {
      enable = true;
    };
    rabbitmq = {
      enable = true;
    };
    redis.servers = {
      logos = {
        enable = true;
      };
    };
    stirling-pdf = {
      enable = true;
      environment = {
        INSTALL_BOOK_AND_ADVANCED_HTML_OPS = "true";
        SERVER_PORT = 8070;
      };
    };
    sunshine = {
      enable = true;
    };
    tailscale = {
      enable = true;
    };
    # touchegg = {
    #   enable = false;
    # };
    # tts.servers = {
    #   logos = {
    #     enable = true;
    #   };
    # };
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };
      # videoDrivers = [ "intel" ];
    };
    zookeeper = {
      enable = true;
    };
  };

  systemd.services = {
    apache-kafka.wantedBy = lib.mkForce [ ];
    # caddy.wantedBy = lib.mkForce [ ];
    clamav-daemon.wantedBy = lib.mkForce [ ];
    cloudflare-warp.wantedBy = lib.mkForce [ ];
    distccd.wantedBy = lib.mkForce [ ];
    docker.wantedBy = lib.mkForce [ ];
    elasticsearch.wantedBy = lib.mkForce [ ];
    fwupd.wantedBy = lib.mkForce [ ];
    geth-logos.wantedBy = lib.mkForce [ ];
    guix-daemon.wantedBy = lib.mkForce [ ];
    jenkins.wantedBy = lib.mkForce [ ];
    k3s.wantedBy = lib.mkForce [ ];
    libvirtd.wantedBy = lib.mkForce [ ];
    libvirt-guests.wantedBy = lib.mkForce [ ];
    logrotate-checkconf.wantedBy = lib.mkForce [ ];
    mysql.wantedBy = lib.mkForce [ ];
    # nginx.wantedBy = lib.mkForce [ ];
    ollama.wantedBy = lib.mkForce [ ];
    postgresql.wantedBy = lib.mkForce [ ];
    rabbitmq.wantedBy = lib.mkForce [ ];
    redis-logos.wantedBy = lib.mkForce [ ];
    stirling-pdf.wantedBy = lib.mkForce [ ];
    sunshine.wantedBy = lib.mkForce [ ];
    tailscale.wantedBy = lib.mkForce [ ];
    zookeeper.wantedBy = lib.mkForce [ ];
  };

  system.stateVersion = "24.11"; # Did you read the comment?

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  virtualisation = {
    docker = {
      enable = true;
    };
    libvirtd = {
      enable = true;
      qemu = {
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    lxc = {
      enable = true;
    };
    spiceUSBRedirection.enable = true;
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
}
