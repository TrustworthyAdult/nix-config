{ ... }:
{
  flake.modules.nixos.zsh =
    { pkgs, ... }:
    {
      programs.zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
      };
      programs.starship.enable = true;
      environment.systemPackages = [ pkgs.zoxide ];
    };
}
