{
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      clash-meta
    ];
  };
  networking = {
    proxy = {
      default = "http://localhost:7890";
      noProxy = "127.0.0.1,localhost,internal.domain";
    };
  };
}
