{ inputs, ... }: {
  flake.modules.nixos.environment = { pkgs, ... }: {
    programs.mango.enable = true;

    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
