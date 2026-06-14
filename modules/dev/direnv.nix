{ ... }:
{
  flake.modules.nixos.direnv =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.direnv
        pkgs.nix-direnv
      ];

      # Wire nix-direnv into direnv so `use flake` is fast and cached.
      environment.etc."direnv/direnvrc".source =
        "${pkgs.nix-direnv}/share/nix-direnv/direnvrc";

      # Hook direnv into interactive zsh sessions.
      programs.zsh.interactiveShellInit = ''
        eval "$(direnv hook zsh)"
      '';
    };
}
