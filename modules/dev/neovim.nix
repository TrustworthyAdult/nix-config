{ inputs, ... }: {
  flake.modules.nixos.neovim = { pkgs, ... }: {
    environment.systemPackages = [
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [{
          config.vim = {
            theme.enable = false;
            extraPlugins = {
              kanagawa = {
                package = pkgs.vimPlugins.kanagawa-nvim;
                setup = "require('kanagawa').setup({ transparent = true })";
              };
            };
            luaConfigPost = ''
              vim.cmd.colorscheme("kanagawa-dragon")
            '';
            binds.whichKey.enable = true;
            telescope.enable = true;
            utility.oil-nvim = {
                enable = true;
                gitStatus.enable = true;
            };
          };
        }];
      }).neovim
    ];
  };
}
