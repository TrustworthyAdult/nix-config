{ inputs, config, ... }:
{
  flake.modules.nixos.ghostty = {
    imports = [ inputs.wrappers.nixosModules.ghostty ];

    wrappers.ghostty = {
      enable = true;
      settings.theme = config.theme.ghostty;
    };
  };
}
