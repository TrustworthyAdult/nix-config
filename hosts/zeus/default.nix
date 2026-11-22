{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      ./hardware-configuration.nix
      ../../modules/locale.nix
      ../../modules/boot.nix
    ];

  networking.hostName = "zeus"; # Define your hostname.
  networking.networkmanager.enable = true;
  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  console.keyMap = "uk";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users."michaelr" = {
    isNormalUser = true;
    description = "Michael Ross";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;

  programs.git = {
  	enable = true;
	config.user = {
		name = "Michael Ross";
		email = "michaeljrossdev@gmail.com";
	};
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
     neovim
     gh
  ];

  system.stateVersion = "26.05";
}
