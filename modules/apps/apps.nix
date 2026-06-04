{ ... }: {
  flake.modules.nixos.apps = { pkgs, ... }: {
    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
      ghostty
    ];
  };
}
