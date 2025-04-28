{
  inputs,
  pkgs,
  ...
}:
{
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" ];
    kernelPackages = pkgs.linuxPackages_rpi4;
    kernelParams = [
      "8250.nr_uarts=1"
      "console=ttyAMA0,115200"
      "console=tty1"
      "cma=128M"
      "snd_bcm2835.enable_hdmi=1"
      "snd_bcm2835.enable_headphones=1"
    ];
    loader = {
      generic-extlinux-compatible.enable = true;
      grub.enable = false;
      raspberryPi.firmwareConfig = ''
        dtparam=audio=on
      '';
    };
  };
  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];
  hardware = {
    raspberry-pi."4" = {
      apply-overlays-dtmerge.enable = true;
      fkms-3d.enable = true;
    };
    deviceTree = {
      enable = true;
      filter = "*rpi-4-*.dtb";
      overlays = [
        {
          name = "spi";
          dtsoFile = ./spi0-0cd.dtso;
        }
      ];
    };
  };
  imports = [
    ./modules/hardware-common.nix
    inputs.nixos-hardware.nixosModules.raspberry-pi
    .4
  ];
  # Prevent host becoming unreachable on wifi after some time.
  networking.networkmanager.wifi.powersave = false;
}
