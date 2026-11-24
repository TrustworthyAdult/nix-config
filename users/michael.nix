{
  users.users."michael" = {
    isNormalUser = true;
    description = "Michael Ross";
	initialPassword = "changeme";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };
}
