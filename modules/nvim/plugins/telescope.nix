{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions.fzf-native.enable = true;

      keymaps = {
        # Find files using Telescope command-line sugar.
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
        "<leader>fh" = "help_tags";
        "<leader>fd" = "diagnostics";
        "<leader>fr" = "oldfiles";
        "<leader>fc" = "grep_string";
        "<leader>fl" = "lsp_document_symbols";

        # FZF like bindings
        "<C-p>" = "git_files";
        "<leader>p" = "oldfiles";
        "<C-f>" = "live_grep";
      };

      settings.defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
          "%.pdf"
        ];
        set_env.COLORTERM = "truecolor";
        layout_strategy = "vertical";
        path_display = ["smart"];
        mappings.i = {
          "<C-j>".__raw = "require('telescope.actions').move_selection_next";
          "<C-k>".__raw = "require('telescope.actions').move_selection_previous";
          "<C-q>".__raw = "require('telescope.actions').smart_send_to_qflist";
          "<C-t>".__raw = "require('trouble.sources.telescope').open";
          "<esc>".__raw = "require('telescope.actions').close";
        };
      };
    };

    keymaps = [
      # Find TODOs
      {
        mode = "n";
        key = "<C-t>";
        action.__raw = ''
          function()
            require('telescope.builtin').live_grep({
              default_text="TODO",
              initial_mode="normal"
            })
          end
        '';
        options = {
          silent = true;
          desc = "Grep TODOs";
        };
      }
      # Todos via todo-comments Telescope integration
      {
        mode = "n";
        key = "<leader>ft";
        action = "<cmd>TodoTelescope<CR>";
        options.desc = "Find TODO Comments";
      }
      # Aerial outline via Telescope
      {
        mode = "n";
        key = "<leader>fo";
        action = "<cmd>Telescope aerial<CR>";
        options.desc = "Find In Outline";
      }
      # Find files scoped to the nvim config
      {
        mode = "n";
        key = "<leader>fn";
        action.__raw = ''
          function()
            require('telescope.builtin').find_files({
              cwd = vim.fn.stdpath('config'),
            })
          end
        '';
        options.desc = "Find Nvim Config Files";
      }
    ];
  };
}
