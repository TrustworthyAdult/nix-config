{ config, pkgs, ... }:

{
  networking.hostName = "zeus";

  imports =
    [
      ./hardware-configuration.nix
      ../../modules/locale.nix
      ../../modules/boot.nix
      ../../modules/networking.nix
      ../../modules/desktop-gnome.nix
      ../../modules/nix.nix
      ../../modules/audio.nix
      ../../modules/git.nix
      ../../users/michael.nix
    ];

  services.printing.enable = true;

  programs.firefox.enable = true;
  programs.zsh.enable = true;



  environment.systemPackages = with pkgs; [
     neovim
     gh
  ];

  system.stateVersion = "26.05";
}
