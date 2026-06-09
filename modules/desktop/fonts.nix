{ ... }:
{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts = {
        enableDefaultPackages = true;

        packages = with pkgs; [
          inter
          nerd-fonts.jetbrains-mono
          nerd-fonts.blex-mono
          nerd-fonts.hurmit
        ];

        fontconfig = {
          defaultFonts = {
            sansSerif = [ "Inter" ];
            monospace = [ "JetBrainsMono Nerd Font" ];
          };
        };
      };
    };
}
