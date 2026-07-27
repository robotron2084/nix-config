{lib, ...}: {
  programs.nixvim = {
    plugins.trouble.enable = true;
    keymaps =
      lib.mapAttrsToList
      (key: spec: {
        mode = "n";
        inherit key;
        action = spec.action;
        options.desc = spec.desc;
      }) {
        "<leader>xq" = {
          action = "<cmd>Trouble quickfix toggle<CR>";
          desc = "Trouble: Quickfix List";
        };
        "<leader>xd" = {
          action = "<cmd>Trouble diagnostics filter.buf=0<CR>";
          desc = "Trouble: Buffer Diagnostics";
        };
        "<leader>xw" = {
          action = "<cmd>Trouble diagnostics toggle<CR>";
          desc = "Trouble: Workspace Diagnostics";
        };
        "<leader>xt" = {
          action = "<cmd>Trouble todo toggle<CR>";
          desc = "Trouble: TODOs";
        };
      };
  };
}
