{ ... }:
{
  flake.modules.nixos.dolphin =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.kdePackages.dolphin
        pkgs.kdePackages.qt6ct
      ];
    };
}
