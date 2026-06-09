{ ... }:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    let
      nordPalette = pkgs.writeShellScript "ly-nord-palette" ''
        printf '\e]P02E3440'  #  0  black   Nord0   base00
        printf '\e]P1BF616A'  #  1  red     Nord11  base08
        printf '\e]P2A3BE8C'  #  2  green   Nord14  base0B
        printf '\e]P3EBCB8B'  #  3  yellow  Nord13  base0A
        printf '\e]P481A1C1'  #  4  blue    Nord9   base0D
        printf '\e]P5B48EAD'  #  5  magenta Nord15  base0E
        printf '\e]P688C0D0'  #  6  cyan    Nord8   base0C
        printf '\e]P7E5E9F0'  #  7  white   Nord5   base05
        printf '\e]P84C566A'  #  8  br.blk  Nord3   base03
        printf '\e]P9BF616A'  #  9  br.red  Nord11  base08
        printf '\e]PAA3BE8C'  # 10  br.grn  Nord14  base0B
        printf '\e]PBEBCB8B'  # 11  br.yel  Nord13  base0A
        printf '\e]PC81A1C1'  # 12  br.blu  Nord9   base0D
        printf '\e]PDB48EAD'  # 13  br.mag  Nord15  base0E
        printf '\e]PE8FBCBB'  # 14  br.cyn  Nord7   base07
        printf '\e]PFECEFF4'  # 15  br.wht  Nord6   base06
      '';
    in
    {
      services.displayManager.ly = {
        enable = true;
        settings = {
          start_cmd = "${nordPalette}";
          bg = "0x00000001"; # TB_BLACK
          fg = "0x00000008"; # TB_WHITE
          border_fg = "0x00000007"; # TB_CYAN
          error_bg = "0x00000001"; # TB_BLACK
          error_fg = "0x01000002"; # TB_RED
          cmatrix_fg = "0x00000007"; # TB_CYAN
          cmatrix_head_col = "0x01000008"; # TB_WHITE

          animation = "none";

          # Explicitly false — the Linux VT cannot render true color escape sequences.
          full_color = false;

          hide_borders = false;
          clock = "%H:%M";
          hide_version_string = true;
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
