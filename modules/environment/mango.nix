{ ... }: {
  flake.modules.nixos.mango = {
    programs.mango.enable = true;
  };
}
