{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = [
      pkgs.csharpier
      pkgs.alejandra
      pkgs.ruff
      pkgs.prettier
      pkgs.astyle
      pkgs.clang-tools # provides clang-format
      pkgs.stylua
    ];
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          cs = ["csharpier"];
          python = ["ruff_format"];
          rust = ["rustfmt"];
          css = ["prettier"];
          nix = ["alejandra"];
          java = ["astyle"];
          c = ["clang_format"];
          lua = ["stylua"];
        };
        # Only these filetypes autoformat on save; everything else (e.g. cs)
        # is manual only, via the range-format keymap below.
        format_on_save.__raw = ''
          function(bufnr)
            local autoformat_filetypes = { "nix", "lua" }
            if vim.tbl_contains(autoformat_filetypes, vim.bo[bufnr].filetype) then
              return { timeout_ms = 500, lsp_format = "fallback" }
            end
          end
        '';
        formatters = {
          clang_format = {
            prepend_args = ["-style={BasedOnStyle: LLVM, IndentWidth: 4}" "--fallback-style=LLVM"];
          };
          # prettier = {
          # 	prepend_args = { "--use-tabs", "--tab-width", "4" },
          # },
        };
      };
    };

    keymaps = [
      {
        mode = "v";
        key = "<leader>cf";
        action.__raw = ''
          function()
            require("conform").format({ lsp_format = "fallback" })
          end
        '';
        options.desc = "Format Selection (Conform)";
      }
    ];
  };
}
