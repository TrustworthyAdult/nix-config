{ pkgs, ... }:
{
  services.printing.enable = true;

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    gh
  ];
}
