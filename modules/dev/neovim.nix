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
                };

                # --- binds ---
                binds.whichKey.enable = true;

                # --- navigation ---
                mini.pick.enable = true;
                utility.oil-nvim = {
                  enable = true;
                  gitStatus.enable = true;
                };
                maps.normal = {
                  "<leader>ff" = {
                    action = "<cmd>lua MiniPick.builtin.files()<CR>";
                    desc = "Find files";
                    silent = true;
                  };
                  "<leader>fg" = {
                    action = "<cmd>lua MiniPick.builtin.grep_live()<CR>";
                    desc = "Live grep";
                    silent = true;
                  };
                  "<leader>fb" = {
                    action = "<cmd>lua MiniPick.builtin.buffers()<CR>";
                    desc = "Buffers";
                    silent = true;
                  };
                  "<leader>fh" = {
                    action = "<cmd>lua MiniPick.builtin.help()<CR>";
                    desc = "Help";
                    silent = true;
                  };
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
