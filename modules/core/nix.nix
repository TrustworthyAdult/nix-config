{ ... }:
{
  flake.modules.nixos.nix =
    { pkgs, ... }:
    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = [ pkgs.nixfmt ];
    };
}
