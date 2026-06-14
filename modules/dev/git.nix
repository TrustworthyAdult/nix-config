{ ... }:
{
  flake.modules.nixos.git =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.git
        pkgs.gh
        pkgs.delta
      ];

      # System-level git config; the user's ~/.gitconfig still overrides this.
      environment.etc.gitconfig.text = ''
        [core]
            pager = delta

        [interactive]
            diffFilter = delta --color-only

        [delta]
            navigate = true
            line-numbers = true

        [merge]
            conflictStyle = zdiff3

        [diff]
            colorMoved = default
      '';
    };
}
