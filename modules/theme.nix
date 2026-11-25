# One place to pick the colour scheme. Each tool names it differently,
# so this holds the per-tool spelling; modules read it from `config.theme`.
{ lib, ... }:
{
  options.theme = {
    ghostty = lib.mkOption {
      type = lib.types.str;
      description = "Ghostty theme name.";
    };
    nvf = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "nvf theme name.";
      };
      style = lib.mkOption {
        type = lib.types.str;
        description = "nvf theme style.";
      };
    };
  };

  config.theme = {
    ghostty = "Atom One Dark";
    nvf = {
      name = "onedark";
      style = "dark";
    };
  };
}
