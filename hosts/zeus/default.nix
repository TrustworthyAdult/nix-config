{
  imports = [
    ./hardware-configuration.nix
    ../../modules/audio.nix
    ../../modules/boot.nix
    ../../modules/desktop-gnome.nix
    ../../modules/locale.nix
    ../../modules/networking.nix
    ../../modules/nix.nix
    ../../modules/apps.nix
    ../../modules/ghostty.nix
    ../../modules/zsh.nix
    ../../modules/neovim.nix
    ../../users/michael.nix
  ];

  networking.hostName = "zeus";
  system.stateVersion = "26.05";
}
