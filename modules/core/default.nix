{ self, ... }: {
  flake.modules.nixos.core.imports = with self.modules.nixos; [
    nix
    boot
    networking
    locale
    users
  ];
}
