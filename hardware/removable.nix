{
  ...
}:
{
  boot = {
    extraModulePackages = [ ];
    kernelModules = [ ];
    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "sr_mod"
        "thunderbolt"
        "uas"
        "xhci_pci"
      ];
      kernelModules = [ ];
    };
    loader = {
      grub = {
        device = "nodev";
        efiInstallAsRemovable = true;
        efiSupport = true;
      };
    };
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/rm-nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/rm-boot";
      fsType = "vfat";
    };
  };
  imports = [
    ./modules/hardware-common.nix
  ];
}
