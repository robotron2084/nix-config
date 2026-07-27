{pkgs, ...}: {
  programs.nixvim = {
    plugins.lint = {
      enable = true;
      lintersByFt = {
        javascript = ["eslint_d"];
        typescript = ["eslint_d"];
        javascriptreact = ["eslint_d"];
        typescriptreact = ["eslint_d"];
        svelte = ["eslint_d"];
        python = ["pylint"];
        lua = ["luacheck"];
      };
    };

    extraPackages = with pkgs; [
      eslint_d
      pylint
      lua51Packages.luacheck
    ];

    autoCmd = [
      {
        event = ["BufEnter" "BufWritePost" "InsertLeave"];
        callback.__raw = ''function() require('lint').try_lint() end'';
        group = "lint";
      }
    ];

    autoGroups.lint = {
      clear = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>l";
        action.__raw = ''function() require('lint').try_lint() end'';
        options.desc = "Trigger Linting For Current File";
      }
    ];
  };
}
