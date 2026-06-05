{ ... }:
{
  flake.modules.nixos.zoxide =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.zoxide ];
    };
}
