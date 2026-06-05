{ ... }:
{
  flake.modules.nixos.users =
    { pkgs, ... }:
    {
      users.users."michaelr" = {
        isNormalUser = true;
        description = "Michael Ross";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.zsh;
      };
    };
}
