{
  programs.nixvim.plugins.lspkind = {
    enable = true;

    settings.cmp = {
      enable = true;
      menu = {
        nvim_lsp = "[LSP]";
        nvim_lua = "[api]";
        path = "[path]";
        luasnip = "[snip]";
        buffer = "[buffer]";
      };
    };
  };
}
