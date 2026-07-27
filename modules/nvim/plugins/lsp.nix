{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    # C# LSP (roslyn) is provided by easy-dotnet's own roslyn client; see
    # easy-dotnet.nix. We intentionally do not run a separate `plugins.roslyn`
    # here, to avoid two roslyn clients attaching to the same buffers.
    lsp = {
      inlayHints.enable = true;
      keymaps = [
        {
          key = "K";
          lspBufAction = "hover";
          options.desc = "Hover Documentation";
        }
        {
          key = "gd";
          action.__raw = "require('telescope.builtin').lsp_definitions";
          options.desc = "Go To Definition";
        }
        {
          key = "gD";
          lspBufAction = "declaration";
          options.desc = "Go To Declaration";
        }
        {
          key = "gR";
          action.__raw = "require('telescope.builtin').lsp_references";
          options.desc = "Find References";
        }
        {
          key = "gt";
          action.__raw = "require('telescope.builtin').lsp_type_definitions";
          options.desc = "Go To Type Definition";
        }
        {
          key = "gi";
          action.__raw = "require('telescope.builtin').lsp_implementations";
          options.desc = "Go To Implementation";
        }
        {
          mode = ["n" "v"];
          key = "<leader>ca";
          lspBufAction = "code_action";
          options.desc = "Code Action";
        }
        {
          key = "<leader>rn";
          lspBufAction = "rename";
          options.desc = "Rename Symbol";
        }
        {
          key = "<leader>D";
          action = "<cmd>Telescope diagnostics bufnr=0<CR>";
          options.desc = "Buffer Diagnostics";
        }
        {
          key = "<leader>d";
          action.__raw = "function() vim.diagnostic.open_float() end";
          options.desc = "Line Diagnostics";
        }
        {
          key = "[d";
          action.__raw = "function() vim.diagnostic.jump({ count = -1, float = true }) end";
          options.desc = "Previous Diagnostic";
        }
        {
          key = "]d";
          action.__raw = "function() vim.diagnostic.jump({ count = 1, float = true }) end";
          options.desc = "Next Diagnostic";
        }
        {
          key = "<leader>rs";
          action = "<cmd>LspRestart<CR>";
          options.desc = "Restart LSP";
        }
      ];
      servers = {
        nixd.enable = true;
        ruff.enable = true;
        pyright.enable = true;
        rust_analyzer.enable = true;
        qmlls.enable = true;
        gdscript.enable = true;
        clangd.enable = true;
        ccls.enable = true;
        ts_ls.enable = true;
        asm_lsp = {
          enable = true;
          package = pkgs.asm-lsp;
        };

        html.enable = true;
        cssls.enable = true;
        tailwindcss.enable = true;
        prismals.enable = true;

        svelte = {
          enable = true;
          config.on_attach.__raw = ''
            function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,
              })
            end
          '';
        };

        graphql = {
          enable = true;
          config.filetypes = [
            "graphql"
            "gql"
            "svelte"
            "typescriptreact"
            "javascriptreact"
          ];
        };

        emmet_ls = {
          enable = true;
          config.filetypes = [
            "html"
            "typescriptreact"
            "javascriptreact"
            "css"
            "sass"
            "scss"
            "less"
            "svelte"
          ];
        };

        lua_ls = {
          enable = true;
          config.settings.Lua = {
            diagnostics.globals = ["vim"];
            completion.callSnippet = "Replace";
          };
        };
      };
    };
  };
}
