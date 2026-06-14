{ inputs, ... }:
{
  flake.modules.nixos.neovim =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.ripgrep
        pkgs.fd # used by snacks' projects picker to scan for projects
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
                  name = "everforest";
                  style = "hard";
                  transparent = true;
                };
                ui.borders = {
                  enable = true;
                  globalStyle = "rounded";
                };
                ui.noice = {
                  enable = true;
                  setupOpts = {
                    lsp = {
                      override = {
                        "vim.lsp.util.convert_input_to_markdown_lines" = true;
                        "vim.lsp.util.stylize_markdown" = true;
                      };
                      signature.enabled = true;
                    };
                    presets = {
                      bottom_search = true;
                      command_palette = true;
                      long_message_to_split = true;
                      lsp_doc_border = true;
                    };
                  };
                };
                notify.nvim-notify = {
                  enable = true;
                  setupOpts = {
                    render = "compact";
                    stages = "fade_in_slide_out";
                    background_colour = "#272e33";
                  };
                };

                # --- binds ---
                binds.whichKey.enable = true;

                # --- navigation ---
                utility.snacks-nvim = {
                  enable = true;
                  setupOpts = {
                    picker = {
                      enabled = true;
                      # Where the projects picker looks for projects.
                      sources.projects.dev = [ "~/Projects" ];
                    };
                    # Dashboard shown when running `nvim` with no file.
                    # Keys are snacks' functional defaults plus a project
                    # picker; the default Config/Lazy/Restore-Session keys are
                    # dropped as nothing in this config backs them.
                    dashboard = {
                      enabled = true;
                      # Default sections minus "startup", which needs
                      # lazy.nvim's stats (unused here) and otherwise errors.
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
                          key = "p";
                          desc = "Projects";
                          action = ":lua Snacks.picker.projects()";
                        }
                        {
                          key = "f";
                          desc = "Find File";
                          action = ":lua Snacks.dashboard.pick('files')";
                        }
                        {
                          key = "n";
                          desc = "New File";
                          action = ":ene | startinsert";
                        }
                        {
                          key = "g";
                          desc = "Find Text";
                          action = ":lua Snacks.dashboard.pick('live_grep')";
                        }
                        {
                          key = "r";
                          desc = "Recent Files";
                          action = ":lua Snacks.dashboard.pick('oldfiles')";
                        }
                        {
                          key = "q";
                          desc = "Quit";
                          action = ":qa";
                        }
                      ];
                    };
                  };
                };
                utility.oil-nvim = {
                  enable = true;
                  gitStatus.enable = true;
                };
                # Sync nvim's env with direnv so flake devShell tooling
                # (e.g. rust-analyzer) is available regardless of launch dir.
                utility.direnv.enable = true;
                # Auto-detect the project root and chdir to it on buffer open.
                # The resulting :cd fires DirChanged -> direnv loads the
                # project's .envrc, so opening a file any way (not just from
                # inside the dir) picks up the flake's tooling.
                projects.project-nvim = {
                  enable = true;
                  setupOpts = {
                    manual_mode = false;
                    # Pattern detection (.git/flake.nix/etc.) covers our repos
                    # and avoids the "lsp" method, which calls a deprecated
                    # vim.lsp API and prints a warning on startup.
                    detection_methods = [ "pattern" ];
                  };
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
                  # lsp — override neovim's native LSP keys with snacks pickers
                  # nvf's <leader>lgX equivalents are nulled out below
                  "gd" = {
                    action = "<cmd>lua Snacks.picker.lsp_definitions()<CR>";
                    desc = "Go to definition";
                    silent = true;
                  };
                  "gD" = {
                    action = "<cmd>lua Snacks.picker.lsp_declarations()<CR>";
                    desc = "Go to declaration";
                    silent = true;
                  };
                  "grr" = {
                    action = "<cmd>lua Snacks.picker.lsp_references()<CR>";
                    desc = "References";
                    silent = true;
                  };
                  "gri" = {
                    action = "<cmd>lua Snacks.picker.lsp_implementations()<CR>";
                    desc = "Implementations";
                    silent = true;
                  };
                  "grt" = {
                    action = "<cmd>lua Snacks.picker.lsp_type_definitions()<CR>";
                    desc = "Type definition";
                    silent = true;
                  };
                  "gO" = {
                    action = "<cmd>lua Snacks.picker.lsp_symbols()<CR>";
                    desc = "Document symbols";
                    silent = true;
                  };
                  # lsp finder shortcuts
                  "<leader>fs" = {
                    action = "<cmd>lua Snacks.picker.lsp_symbols()<CR>";
                    desc = "LSP document symbols";
                    silent = true;
                  };
                  "<leader>fS" = {
                    action = "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>";
                    desc = "LSP workspace symbols";
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
                    keymap = {
                      "<C-n>" = [ "select_next" "fallback" ];
                      "<C-p>" = [ "select_prev" "fallback" ];
                      "<C-y>" = [ "accept" "fallback" ];
                    };
                  };
                };

                # --- diagnostics ---
                luaConfigRC.diagnosticFloat = ''
                  vim.diagnostic.config({
                    float = { border = "rounded" },
                  })
                '';

                # --- lsp ---
                lsp = {
                  enable = true;
                  mappings = {
                    goToDefinition = null;
                    goToDeclaration = null;
                    goToType = null;
                    listImplementations = null;
                    listReferences = null;
                    listDocumentSymbols = null;
                    listWorkspaceSymbols = null;
                  };
                };

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
