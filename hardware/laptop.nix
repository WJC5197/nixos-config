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
        "xhci_pci"
      ];
      kernelModules = [ ];
    };
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/efi" = {
      device = "/dev/disk/by-label/efi";
      fsType = "vfat";
    };
  };

  imports = [
    (import ./modules/grub2-theme-uefi-grub.nix {
      efiSysMountPoint = "/efi";
      theme = "tela";
    })
    ./modules/hardware-common.nix
  ];
}
