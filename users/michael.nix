{ ... }:
{
  users.users.michael = {
    isNormalUser = true;
    description = "Michael Ross";
    initialPassword = "changeme";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    config.user = {
      name = "Michael Ross";
      email = "michaeljrossdev@gmail.com";
    };
  };
}
