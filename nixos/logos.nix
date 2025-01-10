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
      brightnessctl
      ghostscript
      linuxHeaders
      linux-manual
      lm_sensors
      man-pages
      man-pages-posix
      wayland-utils
      unzip
      vulkan-tools
      xsel
      xdg-utils
    ];
    wordlist = {
      enable = true;
    };
  };

  imports = [
    ./modules/nixos-common.nix
    ./modules/zsh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
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

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  services = {
    acpid = {
      enable = true;
      logEvents = true;
    };
    displayManager = {
      ly = {
        enable = true;
        settings = {
          animation = "matrix";
        };
      };
    };
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
    printing = {
      enable = true;
    };
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
  };

  systemd.services = {
    libvirtd.wantedBy = lib.mkForce [ ];
    libvirt-guests.wantedBy = lib.mkForce [ ];
    mysql.wantedBy = lib.mkForce [ ];
  };

  system.stateVersion = "24.11"; # Did you read the comment?

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  virtualisation = {
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
