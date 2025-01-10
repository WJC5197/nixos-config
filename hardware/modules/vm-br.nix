{
  networking = {
    bridges = {
      "vm-br" = {
        interfaces = [ 
          # "wlp0s20f3"
        ];
      };
    };
    interfaces.vm-br = {
      # useDHCP = true;
      ipv4.addresses = [
        {
          address = "192.168.1.1";
          prefixLength = 24;
        }
      ];
    };
    nat = {
      enable = true;
      internalInterfaces = [ "vm-br" ];
      externalInterface = "wlp0s20f3";
    };
  };
}
