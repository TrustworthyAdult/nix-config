{
  description = "my nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";
    systems.url = "github:nix-systems/default";
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v4.7.7";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    zen-browser.url = "github:youwen5/zen-browser-flake";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.flake-parts.flakeModules.modules
        (inputs.import-tree ./modules)
        (inputs.import-tree ./hosts)
      ];
      systems = import inputs.systems;
      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-tree;
        };
    };
}
