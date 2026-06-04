{ ... }: {
  flake.modules.nixos.users = {
    users.users."michaelr" = {
      isNormalUser = true;
      description = "Michael Ross";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
