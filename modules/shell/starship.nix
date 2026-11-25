# Starship prompt: a standalone package (`nix run .#starship`) plus its
# hook into the zsh feature. Both live here because both are about starship.
{ inputs, self, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.starship = inputs.wrappers.wrappers.starship.wrap {
        inherit pkgs;
        preset = "nerd-font-symbols";
        settings = {
          add_newline = false;
          character = {
            success_symbol = "[λ](bold green)";
            error_symbol = "[λ](bold red)";
          };
          directory.truncation_length = 3;
          directory.style = "bold cyan";
          cmd_duration.min_time = 2000;
        };
      };
    };

  flake.modules.nixos.zsh =
    { pkgs, lib, ... }:
    let
      starship = self.packages.${pkgs.stdenv.hostPlatform.system}.starship;
    in
    {
      wrappers.zsh = {
        # `starship init` hard-codes the unwrapped binary into the prompt,
        # so the config path has to be exported from the shell itself.
        env.STARSHIP_CONFIG = "${starship}/starship.toml";

        zshrc.content = lib.mkAfter ''
          eval "$(${lib.getExe starship} init zsh)"
        '';
      };
    };
}
