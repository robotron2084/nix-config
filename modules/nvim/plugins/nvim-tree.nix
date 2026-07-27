{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>ee";
        action = "<cmd>NvimTreeToggle<CR>";
        options.desc = "Toggle Nvim-tree";
      }
      {
        mode = "n";
        key = "<leader>ef";
        action = "<cmd>NvimTreeFindFileToggle<CR>";
        options.desc = "Focus/Reveal File In Nvim-tree";
      }
    ];

    plugins.nvim-tree = {
      enable = true;
      autoClose = false;

      settings = {
        update_focused_file.enable = true;
        view = {
          # width = 50;
          # adaptive_size = true;
          relativenumber = true;
          float = {
            enable = true;
            open_win_config = {
              __raw = ''
                function()
                  local border_size = 10
                  local scr_w = vim.opt.columns:get()
                  local scr_h = vim.opt.lines:get()
                  local tree_w = scr_w - border_size
                  local tree_h = scr_h - border_size

                  return {
                    border = "double",
                    relative = "editor",
                    width = tree_w,
                    height = tree_h,
                    col = (scr_w - tree_w) / 2,
                    row = (scr_h - tree_h) / 2,
                  }
                end
              '';
            };
          };
        };
      };
    };
  };
}
