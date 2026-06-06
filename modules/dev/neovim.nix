{ inputs, ... }:
{
  flake.modules.nixos.neovim =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.ripgrep
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
                utility.snacks-nvim = {
                  enable = true;
                  setupOpts.picker.enabled = true;
                };
                utility.oil-nvim = {
                  enable = true;
                  gitStatus.enable = true;
                };
                maps.normal = {
                  # files
                  "<leader>ff" = {
                    action = "<cmd>lua Snacks.picker.files()<CR>";
                    desc = "Find files";
                    silent = true;
                  };
                  "<leader>fr" = {
                    action = "<cmd>lua Snacks.picker.recent()<CR>";
                    desc = "Recent files";
                    silent = true;
                  };
                  "<leader>f/" = {
                    action = "<cmd>lua Snacks.picker.lines()<CR>";
                    desc = "Search buffer lines";
                    silent = true;
                  };
                  # grep
                  "<leader>fg" = {
                    action = "<cmd>lua Snacks.picker.grep()<CR>";
                    desc = "Live grep";
                    silent = true;
                  };
                  # buffers / ui
                  "<leader>fb" = {
                    action = "<cmd>lua Snacks.picker.buffers()<CR>";
                    desc = "Buffers";
                    silent = true;
                  };
                  "<leader>fR" = {
                    action = "<cmd>lua Snacks.picker.resume()<CR>";
                    desc = "Resume picker";
                    silent = true;
                  };
                  # help / meta
                  "<leader>fh" = {
                    action = "<cmd>lua Snacks.picker.help()<CR>";
                    desc = "Help";
                    silent = true;
                  };
                  "<leader>fk" = {
                    action = "<cmd>lua Snacks.picker.vim_keymaps()<CR>";
                    desc = "Keymaps";
                    silent = true;
                  };
                  "<leader>fc" = {
                    action = "<cmd>lua Snacks.picker.vim_history()<CR>";
                    desc = "Command history";
                    silent = true;
                  };
                  # lsp
                  "<leader>fs" = {
                    action = "<cmd>lua Snacks.picker.lsp_symbols()<CR>";
                    desc = "LSP symbols";
                    silent = true;
                  };
                  "<leader>fd" = {
                    action = "<cmd>lua Snacks.picker.diagnostics()<CR>";
                    desc = "Diagnostics";
                    silent = true;
                  };
                  # git
                  "<leader>fG" = {
                    action = "<cmd>lua Snacks.picker.git_files()<CR>";
                    desc = "Git files";
                    silent = true;
                  };
                  "<leader>ft" = {
                    action = "<cmd>lua Snacks.picker.git_status()<CR>";
                    desc = "Git status";
                    silent = true;
                  };
                  "<leader>fl" = {
                    action = "<cmd>lua Snacks.picker.git_log()<CR>";
                    desc = "Git log";
                    silent = true;
                  };
                  # vim state
                  "<leader>fm" = {
                    action = "<cmd>lua Snacks.picker.vim_marks()<CR>";
                    desc = "Marks";
                    silent = true;
                  };
                  "<leader>fj" = {
                    action = "<cmd>lua Snacks.picker.vim_jumps()<CR>";
                    desc = "Jump list";
                    silent = true;
                  };
                  "<leader>fu" = {
                    action = "<cmd>lua Snacks.picker.undo()<CR>";
                    desc = "Undo history";
                    silent = true;
                  };
                  "<leader>fq" = {
                    action = "<cmd>lua Snacks.picker.qf()<CR>";
                    desc = "Quickfix list";
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
