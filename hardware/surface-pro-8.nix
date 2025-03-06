{
  inputs,
  ...
}:

{
  # microsoft-surface.kernelVersion = "6.10.5";
  boot = {
    extraModulePackages = [ ];
    kernelModules = [ "kvm-intel" ];
    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "sr_mod"
        "thunderbolt"
        "xhci_pci"
      ];
      kernelModules = [ "pinctrl_tigerlake" ];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
    };

    "/bak" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=bak" ];
    };

    "/data" = {
      device = "/dev/disk/by-label/Data";
      fsType = "ntfs-3g";
      options = [
        "dmask=0022"
        "fmask=0133"
        "permissions"
        "rw"
      ];
    };

    "/efi" = {
      device = "/dev/disk/by-label/efi";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    "/etc" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=etc" ];
    };

    "/home" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

    "/nix" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    "/root" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };
    "/vm" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=vm" ];
    };
  };

  imports = [
    (import ./modules/grub2-theme-uefi-grub.nix {
      customResolution = "2880x1920";
      efiSysMountPoint = "/efi";
      theme = "tela";
    })
    ./modules/hardware-common.nix
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          energy_performance_preference = "power";
          governor = "powersave";
          turbo = "auto";
        };
        charger = {
          energy_performance_preference = "balance_power";
          governor = "powersave";
          turbo = "auto";
        };
      };
    };
    iptsd = {
      enable = true;
      config = {
        Contacts = {
          ActivationThreshold = 24;
          DeactivationThreshold = 20;
          OrientationThresholdMax = 5;
        };
      };
    };
    tlp = {
      enable = true;
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  virtualisation.docker.storageDriver = "btrfs";
  # powerManagement = {
  #   cpuFreqGovernor = "powersave";
  #   powertop = {
  #     enable = true;
  #   };
  # };

}
