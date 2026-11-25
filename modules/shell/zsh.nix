{ inputs, ... }:
{
  flake.modules.nixos.zsh = {
    imports = [ inputs.wrappers.nixosModules.zsh ];

    programs.zsh.enable = true;

    wrappers.zsh = {
      enable = true;
      asSystemDefault = true;

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
      '';
    };
  };
}
