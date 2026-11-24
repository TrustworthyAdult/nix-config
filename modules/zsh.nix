{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  starship = inputs.wrappers.wrappers.starship.wrap {
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
in
{
  imports = [ inputs.wrappers.nixosModules.zsh ];

  wrappers.zsh = {
    enable = true;
    asSystemDefault = true;

    # `starship init` hard-codes the unwrapped binary into the prompt,
    # so the config path has to be exported from the shell itself.
    env.STARSHIP_CONFIG = "${starship}/starship.toml";
    env.EDITOR = "nvim";

    zshAliases = {
      rebuild = "nixos-rebuild switch --elevate sudo --flake ~/nix-config";
    };

    zshrc.content = ''
      # ZDOTDIR is read-only in the Nix store, so keep history in $HOME.
      HISTFILE=$HOME/.zsh_history
      HISTSIZE=10000
      SAVEHIST=10000
      setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE
      setopt AUTO_CD

      eval "$(${lib.getExe starship} init zsh)"
    '';
  };
}
