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
      core
      desktop
      environment
      apps
      dev
      ./_hardware.nix
    ];

    networking.hostName = "daedalus";
    system.stateVersion = "26.05";
  };
}
