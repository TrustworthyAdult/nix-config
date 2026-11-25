# Neovim via nvf, loosely modelled on LazyVim's defaults:
# onedark (matches Ghostty), snacks (picker, explorer, dashboard, notifier, lazygit),
# blink.cmp, lualine, bufferline, which-key, gitsigns, flash, noice,
# trouble, todo-comments, grug-far, mini.ai/pairs, treesitter + LSP.
{
  inputs,
  config,
  ...
}:
let
  inherit (config) theme;

  # Helper for keymaps that call Lua.
  lua = key: action: desc: {
    inherit key desc;
    mode = "n";
    lua = true;
    action = "function() ${action} end";
  };
in
{
  flake.modules.nixos.neovim = { pkgs, ... }: {
    imports = [ inputs.nvf.nixosModules.default ];

    programs.nvf = {
      enable = true;

      settings.vim = {
        viAlias = true;
        vimAlias = true;

        globals = {
          mapleader = " ";
          maplocalleader = "\\";
        };

        # LazyVim's lua/lazyvim/config/options.lua, trimmed.
        options = {
          number = true;
          relativenumber = true;
          mouse = "a";
          expandtab = true;
          shiftwidth = 2;
          tabstop = 2;
          smartindent = true;
          ignorecase = true;
          smartcase = true;
          signcolumn = "yes";
          cursorline = true;
          wrap = false;
          scrolloff = 4;
          sidescrolloff = 8;
          splitright = true;
          splitbelow = true;
          undofile = true;
          confirm = true;
          laststatus = 3;
          showmode = false;
          timeoutlen = 300;
          updatetime = 200;
        };

        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy.enable = true;
        };

        theme = {
          enable = true;
          inherit (theme.nvf) name style;
        };

        # UI
        statusline.lualine.enable = true;
        tabline.nvimBufferline.enable = true;
        binds.whichKey.enable = true;
        ui.noice.enable = true;
        visuals.nvim-web-devicons.enable = true;

        utility.snacks-nvim = {
          enable = true;
          setupOpts = {
            bigfile.enabled = true;
            dashboard = {
              enabled = true;
              # Snacks' default layout includes a "startup" section that needs
              # lazy.nvim, which nvf doesn't use. Its "Config" and "Session"
              # entries don't apply here either.
              sections = [
                { section = "header"; }
                {
                  section = "keys";
                  gap = 1;
                  padding = 1;
                }
              ];
              preset.keys = [
                {
                  icon = " ";
                  key = "f";
                  desc = "Find File";
                  action = ":lua Snacks.dashboard.pick('files')";
                }
                {
                  icon = " ";
                  key = "n";
                  desc = "New File";
                  action = ":ene | startinsert";
                }
                {
                  icon = " ";
                  key = "g";
                  desc = "Find Text";
                  action = ":lua Snacks.dashboard.pick('live_grep')";
                }
                {
                  icon = " ";
                  key = "r";
                  desc = "Recent Files";
                  action = ":lua Snacks.dashboard.pick('oldfiles')";
                }
                {
                  icon = " ";
                  key = "q";
                  desc = "Quit";
                  action = ":qa";
                }
              ];
            };
            explorer.enabled = true;
            indent.enabled = true;
            input.enabled = true;
            lazygit.enabled = true;
            notifier.enabled = true;
            picker.enabled = true;
            quickfile.enabled = true;
            scope.enabled = true;
            scroll.enabled = true;
            statuscolumn.enabled = true;
            words.enabled = true;
          };
        };

        # Editing
        autocomplete.blink-cmp.enable = true;
        mini.ai.enable = true;
        mini.pairs.enable = true;
        utility.motion.flash-nvim.enable = true;
        utility.grug-far-nvim.enable = true;
        notes.todo-comments.enable = true;
        git.gitsigns.enable = true;

        # Treesitter, LSP, formatting
        treesitter.enable = true;
        lsp = {
          enable = true;
          formatOnSave = true;
          trouble.enable = true;
        };
        languages = {
          enableTreesitter = true;
          enableFormat = true;
          nix.enable = true;
          lua.enable = true;
          bash.enable = true;
          markdown.enable = true;
        };

        extraPackages = [ pkgs.lazygit ];

        # A subset of LazyVim's default keymaps.
        keymaps = [
          # Pickers
          (lua "<leader><space>" "Snacks.picker.files()" "Find files")
          (lua "<leader>/" "Snacks.picker.grep()" "Grep")
          (lua "<leader>," "Snacks.picker.buffers()" "Buffers")
          (lua "<leader>:" "Snacks.picker.command_history()" "Command history")
          (lua "<leader>ff" "Snacks.picker.files()" "Find files")
          (lua "<leader>fg" "Snacks.picker.git_files()" "Git files")
          (lua "<leader>fr" "Snacks.picker.recent()" "Recent files")
          (lua "<leader>sg" "Snacks.picker.grep()" "Grep")
          (lua "<leader>sh" "Snacks.picker.help()" "Help pages")
          (lua "<leader>sk" "Snacks.picker.keymaps()" "Keymaps")
          (lua "<leader>sd" "Snacks.picker.diagnostics()" "Diagnostics")

          # Explorer, git, notifications
          (lua "<leader>e" "Snacks.explorer()" "Explorer")
          (lua "<leader>gg" "Snacks.lazygit()" "Lazygit")
          (lua "<leader>un" "Snacks.notifier.hide()" "Dismiss notifications")

          # Buffers
          (lua "<leader>bd" "Snacks.bufdelete()" "Delete buffer")
          {
            key = "<S-h>";
            mode = "n";
            action = "<cmd>bprevious<cr>";
            desc = "Prev buffer";
          }
          {
            key = "<S-l>";
            mode = "n";
            action = "<cmd>bnext<cr>";
            desc = "Next buffer";
          }

          # Windows
          {
            key = "<C-h>";
            mode = "n";
            action = "<C-w>h";
            desc = "Go to left window";
          }
          {
            key = "<C-j>";
            mode = "n";
            action = "<C-w>j";
            desc = "Go to lower window";
          }
          {
            key = "<C-k>";
            mode = "n";
            action = "<C-w>k";
            desc = "Go to upper window";
          }
          {
            key = "<C-l>";
            mode = "n";
            action = "<C-w>l";
            desc = "Go to right window";
          }
          {
            key = "<leader>-";
            mode = "n";
            action = "<C-w>s";
            desc = "Split below";
          }
          {
            key = "<leader>|";
            mode = "n";
            action = "<C-w>v";
            desc = "Split right";
          }

          # Misc
          {
            key = "<C-s>";
            mode = [
              "n"
              "i"
              "x"
            ];
            action = "<cmd>w<cr><esc>";
            desc = "Save file";
          }
          {
            key = "<esc>";
            mode = "n";
            action = "<cmd>nohlsearch<cr><esc>";
            desc = "Clear search highlight";
          }
          {
            key = "<leader>qq";
            mode = "n";
            action = "<cmd>qa<cr>";
            desc = "Quit all";
          }
          {
            key = "<leader>xx";
            mode = "n";
            action = "<cmd>Trouble diagnostics toggle<cr>";
            desc = "Diagnostics (Trouble)";
          }
          {
            key = "<leader>cf";
            mode = [
              "n"
              "v"
            ];
            lua = true;
            action = "function() vim.lsp.buf.format() end";
            desc = "Format";
          }
        ];
      };
    };
  };
}
