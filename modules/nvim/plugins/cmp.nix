{
  programs.nixvim.plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      preselect = "cmp.PreselectMode.Item";
      sources = [
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "buffer";}
        {name = "dictionary";}
        {name = "luasnip";}
      ];
      snippet.expand = ''
        function(args)
        	require('luasnip').lsp_expand(args.body)
        end
      '';
      mapping = {
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<C-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<C-j>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
    };
  };
}
