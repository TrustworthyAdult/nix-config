# Flake-wide plumbing: enables `flake.modules.<class>.<name>`,
# declares supported systems and the formatter.
{ inputs, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];

  systems = [ "x86_64-linux" ];

  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt-tree;
    };
}
