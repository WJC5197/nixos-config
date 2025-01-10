{
  hardware = {
    # enableAllFirmware = true;
    bluetooth = {
      enable = true;
      input = {
        General = {
          UserspaceHID = true;
        };
      };
      powerOnBoot = true;
      settings = {
        General = {
          # Enable = "Source,Sink,Media,Socket";
          # ControllerMode = "bredr";
          Experimental = true;
          FastConnectable = true;
        };
      };
    };
    enableRedistributableFirmware = true;
    i2c = {
      enable = true;
    };
  };
}
