{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.nixvim = {
    enable = true;
    nixpkgs = {
      source = inputs.nixpkgs;
      config.allowUnfree = true;
    };
    defaultEditor = true;

    opts = {
      shiftwidth = 2;
      smarttab = true;
      tabstop = 2;
      wrap = true;
      softtabstop = 0;
      expandtab = true;
      autoindent = true;
      number = true;
      relativenumber = true;
      clipboard = ["unnamedplus"];
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      cursorline = true;
      signcolumn = "yes";
      splitright = true;
      splitbelow = true;
      timeoutlen = 300;
    };

    globals = {
      mapleader = " ";
      clipboard = lib.mkIf pkgs.stdenv.isLinux "wl-copy";
    };

    extraConfigLua = ''
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local groups = {
            "Normal",
            "NormalNC",
            "SignColumn",
            "LineNr",
            "EndOfBuffer",
            "StatusLine",
            "StatusLineNC",
            "FloatBorder",
            "NormalFloat",
          }
          for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
          end
        end,
      })
    '';

    colorschemes.catppuccin.enable = true;

    dependencies.ripgrep.enable = true;

    clipboard.providers.wl-copy.enable = pkgs.stdenv.isLinux;

    diagnostic.settings = {
      virtual_lines = {
        current_line = true;
      };
      virtual_text = false;
    };

    dependencies.godot = lib.mkIf pkgs.stdenv.isLinux {
      enable = true;
      package = pkgs.godot-mono;
    };

    plugins = {
      gitsigns.enable = true;
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-space>";
              node_incremental = "<C-space>";
              scope_incremental = false;
              node_decremental = "<bs>";
            };
          };
        };
      };
      ts-autotag.enable = true;
      which-key.enable = true;
      lazygit.enable = true;
      tmux-navigator.enable = true;
      todo-comments.enable = true;
      neoscroll = {
        enable = true;
        settings = {
          easing = "quadratic";
        };
      };

      # https://github.com/habamax/vim-godot/?tab=readme-ov-file#setup-neovim-as-an-external-editor-for-godot
      godot = {
        enable = true;
        settings = {
          executable = "godot-mono";
        };
      };

      web-devicons.enable = true;
      mini-pairs.enable = true;
      lspconfig.enable = true;
      friendly-snippets = {
        enable = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        action = "<cmd>nohl<CR>";
        key = "<ESC>";
        options.desc = "No Highlights";
      }
      {
        action.__raw = ''
          function()
            if vim.diagnostic.config().virtual_lines then
              vim.diagnostic.config({ virtual_lines = false })
            else
              vim.diagnostic.config({ virtual_lines = { current_line = true } })
            end
          end
        '';
        key = "<Leader>p";
        options.desc = "Toggle virtual lines diagnostics";
      }
      {
        mode = "i";
        key = "jk";
        action = "<ESC>";
        options.desc = "Exit insert mode with jk";
      }
      {
        mode = "n";
        action = "<cmd>LazyGit<CR>";
        key = "<leader>lg";
        options.desc = "Open LazyGit";
      }
      {
        mode = "n";
        action = "<C-w>s";
        key = "<leader>sh";
        options.desc = "Split Window Horizontally";
      }
      {
        mode = "n";
        action = "<C-w>v";
        key = "<leader>sv";
        options.desc = "Split Window Vertically";
      }
      {
        mode = "n";
        action = "<C-w>=";
        key = "<leader>se";
        options.desc = "Make Splits Equal Size";
      }
      {
        mode = "n";
        action = "<cmd>close<CR>";
        key = "<leader>sx";
        options.desc = "Close Current Split";
      }
      {
        mode = "n";
        action.__raw = ''
          function()
            if vim.w.__maximized then
              vim.cmd("wincmd =")
              vim.w.__maximized = false
            else
              vim.cmd("wincmd _ | wincmd |")
              vim.w.__maximized = true
            end
          end
        '';
        key = "<leader>sm";
        options.desc = "Maximize/Restore Split";
      }
      {
        mode = "n";
        action = "<cmd>tabnew<CR>";
        key = "<leader>to";
        options.desc = "Open New Tab";
      }
      {
        mode = "n";
        action = "<cmd>tabclose<CR>";
        key = "<leader>tx";
        options.desc = "Close Current Tab";
      }
      {
        mode = "n";
        action = "<cmd>tabn<CR>";
        key = "<leader>tn";
        options.desc = "Next Tab";
      }
      {
        mode = "n";
        action = "<cmd>tabp<CR>";
        key = "<leader>tp";
        options.desc = "Previous Tab";
      }
      {
        mode = "n";
        action = "<cmd>tabnew %<CR>";
        key = "<leader>tf";
        options.desc = "Open Current Buffer In New Tab";
      }
      {
        mode = "n";
        action = "<C-a>";
        key = "<leader>+";
        options.desc = "Increment Number";
      }
      {
        mode = "n";
        action = "<C-x>";
        key = "<leader>-";
        options.desc = "Decrement Number";
      }
      {
        mode = "n";
        action = "<cmd>cnext<CR>";
        key = "<M-j>";
        options.desc = "Next Quickfix Item";
      }
      {
        mode = "n";
        action = "<cmd>cprev<CR>";
        key = "<M-k>";
        options.desc = "Previous Quickfix Item";
      }
      {
        mode = "n";
        action = "<cmd>qa<CR>";
        key = "<leader>vx";
        options.desc = "Quit Vim";
      }
      {
        mode = "n";
        action.__raw = ''function() require("todo-comments").jump_next() end'';
        key = "]t";
        options.desc = "Next Todo Comment";
      }
      {
        mode = "n";
        action.__raw = ''function() require("todo-comments").jump_prev() end'';
        key = "[t";
        options.desc = "Previous Todo Comment";
      }
      {
        mode = "n";
        action = ''<cmd>let @+ = expand("%")<CR>'';
        key = "<leader>cp";
        options.desc = "Copy Path To Clipboard.";
      }
    ];
  };

  imports = [
    (import ./plugins {inherit config pkgs;})
  ];
}
