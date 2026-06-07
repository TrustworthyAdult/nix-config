{ ... }:
{
  flake.modules.nixos.desktop = {
    services.displayManager.ly = {
      enable = true;
      settings = {
        full_color = true;
        bg = "0x002E3440";
        fg = "0x00D8DEE9";
        border_fg = "0x0088C0D0";
        error_fg = "0x01BF616A";
      };
    };
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
