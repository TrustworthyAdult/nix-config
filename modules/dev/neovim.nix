{ inputs, ... }:
{
  flake.modules.nixos.neovim =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            {
              config.vim = {

                # --- ui ---
                statusline.lualine.enable = true;
                mini.icons.enable = true;
                theme = {
                  enable = true;
                  name = "nord";
                  transparent = false;
                };
                # extraPlugins = {
                #   kanagawa = {
                #     package = pkgs.vimPlugins.kanagawa-nvim;
                #     setup = "require('kanagawa').setup({ transparent = true })";
                #   };
                # };
                # luaConfigPost = ''
                #   vim.cmd.colorscheme("kanagawa-dragon")
                # '';

                # --- binds ---
                binds.whichKey.enable = true;

                # --- navigation ---
                telescope.enable = true;
                utility.oil-nvim = {
                  enable = true;
                  gitStatus.enable = true;
                };

                # --- completion ---
                autocomplete.blink-cmp = {
                  enable = true;
                  setupOpts = {
                    completion = {
                      menu.border = "rounded";
                      documentation.window.border = "rounded";
                    };
                  };
                };

                # --- lsp ---
                lsp.enable = true;

                # --- languages ---
                languages = {
                  enableTreesitter = true;
                  nix = {
                    enable = true;
                    format.enable = true;
                  };
                  rust = {
                    enable = true;
                    format.enable = true;
                    extensions.crates-nvim.enable = true;
                  };
                  python = {
                    enable = true;
                    format.enable = true;
                  };
                };

              };
            }
          ];
        }).neovim
      ];
    };
}
