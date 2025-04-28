{
  description = "NixOS configuration";

  inputs = {
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/feefc78";
    nixos-wsl = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/NixOS-WSL";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # stylix.url = "github:danth/stylix";
  };
  outputs =
    inputs@{
      nixpkgs,
      ...
    }:
    let
      mkSystem = import ./lib/mksystem.nix {
        inherit inputs nixpkgs overlays;
      };
      overlays = [
        (import ./pkgs)
        inputs.emacs-overlay.overlays.default
      ];
    in
    {
      nixosConfigurations =
        mkSystem "logos-cascade" {
          hardware = "laptop";
          extraModules = [
            ./nixos/modules/docker-host-firewall.nix
            ./nixos/modules/libvirt-host-firewall.nix
            ./nixos/modules/localhost-http-proxy.nix
          ];
          nixos = "logos";
          system = "x86_64-linux";
          users = [
            "monad"
            "root"
            "wjc5197"
          ];
        }
        // mkSystem "logos-morph" {
          dpi = 169;
          hardware = "surface-pro-8";
          extraModules = [
            ./nixos/modules/docker-host-firewall.nix
            ./nixos/modules/libvirt-host-firewall.nix
            ./nixos/modules/localhost-http-proxy.nix
            # ./nixos/modules/nix-substituters.nix
            # (
            #   { pkgs, ... }:
            #   {
            #     home-manager.users.wjc5197 = {
            #       programs.zsh.enable = true;
            #     };
            #   }
            # )
          ];
          nixos = "logos";
          system = "x86_64-linux";
          users = [
            "monad"
            "root"
            "wjc5197"
          ];
        }
        // mkSystem "thoth-vm" {
          hardware = "vm";
          extraModules = [
            ./nixos/modules/libvirt-guest-http-proxy.nix
          ];
          nixos = "thoth";
          system = "x86_64-linux";
          users = [
            "monad"
            "root"
          ];
        }
        // mkSystem "plasma-rm" {
          hardware = "removable";
          extraModules = [
            ./nixos/modules/fish
            ./nixos/modules/localhost-http-proxy.nix
            (
              { pkgs, ... }:
              {
                environment.systemPackages = with pkgs; [
                  gparted
                ];
              }
            )
          ];
          nixos = "plasma";
          system = "x86_64-linux";
          users = [
            "monad"
            "root"
          ];
        }
        // mkSystem "plasma-laptop" {
          hardware = "laptop";
          extraModules = [
            ./nixos/modules/zsh
            ./nixos/modules/localhost-http-proxy.nix
          ];
          nixos = "plasma";
          system = "x86_64-linux";
          users = [
            "monad"
            "root"
            "wjc5197"
          ];
        }
        // mkSystem "thoth-pi" {
          hardware = "raspberry-pi-4";
          extraModules = [
            ./nixos/modules/zsh
            ./nixos/modules/localhost-http-proxy.nix
          ];
          nixos = "thoth";
          system = "aarch64-linux";
          users = [
            "monad"
            "root"
          ];
        };
    };
}
