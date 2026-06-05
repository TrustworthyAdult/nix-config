{ ... }:
{
  flake.modules.nixos.openttd =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.openttd ];
    };
}
