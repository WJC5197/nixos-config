{
  inputs,
  nixpkgs,
  overlays,
  ...
}:

host:
{
  dpi ? 96,
  hardware,
  isDarwin ? false,
  isWSL ? false,
  extraModules ? [ ],
  nixos,
  system,
  users,
  ...
}:

let
  hardwareConfig = ../hardware/${hardware}.nix;
  home-manager =
    if isDarwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;
  nixosConfig = ../nixos/${nixos}.nix;
  systemFunc = if isDarwin then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  usersHomeConfig = nixpkgs.lib.genAttrs users (user: import ../users/${user}/home.nix);
  usersNixOSConfig = builtins.map (user: ../users/${user}/${
    if isDarwin then "darwin" else "nixos"
  }.nix) users;
in
{
  ${host} = systemFunc rec {
    inherit system;
    modules =
      extraModules
      ++ usersNixOSConfig
      ++ [
        {
          networking.hostName = host;
          nixpkgs = {
            # Allow unfree packages.
            config.allowUnfree = true;
            # Apply our overlays. Overlays are keyed by system type so we have
            # to go through and apply our system type. We do this first so
            # the overlays are available globally.
            inherit overlays;
          };
        }

        # Bring in WSL if this is a WSL build
        (if isWSL then inputs.nixos-wsl.nixosModules.wsl else { })
        hardwareConfig
        home-manager.home-manager
        {
          home-manager.backupFileExtension = "nixbak";
          home-manager.extraSpecialArgs = {
            inherit dpi inputs;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.users = usersHomeConfig;
          home-manager.useUserPackages = true;
        }
        nixosConfig
      ];
    specialArgs = { inherit inputs; };
  };
}
