{ self, inputs, ... }:

{
  flake.nixosConfigurations.daedalus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.daedalus
      inputs.mangowm.nixosModules.mango
    ];
  };

  flake.modules.nixos.daedalus = {
    imports = with self.modules.nixos; [
      nix
      boot
      networking
      power
      locale
      users
      zsh
      starship
      audio
      display
      mango
      noctalia
      firefox
      ghostty
      neovim
      git
      gh
      openttd
      zoxide
      ./_hardware.nix
    ];

    networking.hostName = "daedalus";
    system.stateVersion = "26.05";
  };
}
