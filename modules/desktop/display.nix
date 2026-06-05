{ ... }:
{
  flake.modules.nixos.display = {
    services.displayManager.ly.enable = true;
  };
}
