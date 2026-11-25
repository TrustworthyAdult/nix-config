{ inputs, config, ... }:
let
  inherit (config.flake.modules) nixos;
in
{
  flake.modules.nixos.zeus = {
    imports = [
      ./_hardware-configuration.nix

      nixos.boot
      nixos.nix
      nixos.locale
      nixos.networking
      nixos.audio
      nixos.printing

      nixos.gnome
      nixos.niri

      nixos.zsh
      nixos.git
      nixos.gh

      nixos.firefox
      nixos.ghostty
      nixos.neovim

      nixos.michael
    ];

    networking.hostName = "zeus";
    system.stateVersion = "26.05";
  };

  flake.nixosConfigurations.zeus = inputs.nixpkgs.lib.nixosSystem {
    modules = [ nixos.zeus ];
  };
}
