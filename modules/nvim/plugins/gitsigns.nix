{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "]h";
        action.__raw = ''function() require('gitsigns').next_hunk() end'';
        options.desc = "Next Hunk";
      }
      {
        mode = "n";
        key = "[h";
        action.__raw = ''function() require('gitsigns').prev_hunk() end'';
        options.desc = "Previous Hunk";
      }
      {
        mode = "n";
        key = "<leader>hs";
        action.__raw = ''function() require('gitsigns').stage_hunk() end'';
        options.desc = "Stage Hunk";
      }
      {
        mode = "v";
        key = "<leader>hs";
        action.__raw = ''
          function()
            require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end
        '';
        options.desc = "Stage Hunk";
      }
      {
        mode = "n";
        key = "<leader>hr";
        action.__raw = ''function() require('gitsigns').reset_hunk() end'';
        options.desc = "Reset Hunk";
      }
      {
        mode = "v";
        key = "<leader>hr";
        action.__raw = ''
          function()
            require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end
        '';
        options.desc = "Reset Hunk";
      }
      {
        mode = "n";
        key = "<leader>hS";
        action.__raw = ''function() require('gitsigns').stage_buffer() end'';
        options.desc = "Stage Buffer";
      }
      {
        mode = "n";
        key = "<leader>hR";
        action.__raw = ''function() require('gitsigns').reset_buffer() end'';
        options.desc = "Reset Buffer";
      }
      {
        mode = "n";
        key = "<leader>hu";
        action.__raw = ''function() require('gitsigns').undo_stage_hunk() end'';
        options.desc = "Undo Stage Hunk";
      }
      {
        mode = "n";
        key = "<leader>hp";
        action.__raw = ''function() require('gitsigns').preview_hunk() end'';
        options.desc = "Preview Hunk";
      }
      {
        mode = "n";
        key = "<leader>hb";
        action.__raw = ''function() require('gitsigns').blame_line({ full = true }) end'';
        options.desc = "Blame Line";
      }
      {
        mode = "n";
        key = "<leader>hB";
        action.__raw = ''function() require('gitsigns').toggle_current_line_blame() end'';
        options.desc = "Toggle Line Blame";
      }
      {
        mode = "n";
        key = "<leader>hd";
        action.__raw = ''function() require('gitsigns').diffthis() end'';
        options.desc = "Diff This";
      }
      {
        mode = "n";
        key = "<leader>hD";
        action.__raw = ''function() require('gitsigns').diffthis('~') end'';
        options.desc = "Diff This ~";
      }
      {
        mode = ["o" "x"];
        key = "ih";
        action = ":<C-U>Gitsigns select_hunk<CR>";
        options.desc = "Gitsigns Select Hunk";
      }
    ];
  };
}
