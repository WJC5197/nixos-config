{
  ...
}:
{
  # Use the systemd-boot EFI boot loader.
  boot = {
    extraModulePackages = [ ];
    kernelModules = [ ];
    initrd = {
      availableKernelModules = [
        "ahci"
        "sr_mod"
        "sd_mod"
        "virtio_blk"
        "virtio_pci"
        "xhci_pci"
      ];
      kernelModules = [ ];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };
}
