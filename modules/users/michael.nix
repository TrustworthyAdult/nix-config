{
  flake.modules.nixos.michael = {
    users.users.michael = {
      isNormalUser = true;
      description = "Michael Ross";
      initialPassword = "changeme";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };

    programs.git.config.user = {
      name = "Michael Ross";
      email = "michaeljrossdev@gmail.com";
    };
  };
}
