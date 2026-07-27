{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        bigfile.enabled = true;
        quickfile.enabled = true;
        notifier = {
          enabled = true;
          timeout = 3000;
          # Toasts are capped at 40% width with wrap disabled by default, so
          # long/multi-line RPC errors get cut off instead of wrapping.
          width = {
            min = 40;
            max = 0.6;
          };
          wo.wrap = true;
        };
        input.enabled = true;
        bufdelete.enabled = true;
        scope.enabled = true;
        words.enabled = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>rf";
        action.__raw = ''function() Snacks.rename.rename_file() end'';
        options.desc = "Rename File (LSP-aware)";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action.__raw = ''function() Snacks.bufdelete() end'';
        options.desc = "Close Buffer";
      }
      {
        mode = "n";
        key = "<leader>bD";
        action.__raw = ''function() Snacks.bufdelete({ force = true }) end'';
        options.desc = "Close Buffer (Force)";
      }
      {
        mode = "n";
        key = "<leader>bo";
        action.__raw = ''function() Snacks.bufdelete.other() end'';
        options.desc = "Close Other Buffers";
      }
      {
        mode = "n";
        key = "<leader>ba";
        action.__raw = ''function() Snacks.bufdelete.all() end'';
        options.desc = "Close All Buffers";
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>BufferPickDelete<CR>";
        options.desc = "Pick Buffer To Close";
      }
      {
        mode = "n";
        key = "<leader>nh";
        action.__raw = ''function() Snacks.notifier.show_history() end'';
        options.desc = "Notification History (full text)";
      }
    ];
  };
}
