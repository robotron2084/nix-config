{...}: {
  programs.nixvim = {
    # p4nvim is a local, actively-developed, unpublished plugin (no git
    # remote yet), so it's loaded via a runtimepath append rather than
    # packaged through buildVimPlugin/extraPlugins: edits to its Lua files
    # take effect immediately (just restart/:source), with no rebuild
    # needed. Once it stabilizes and gets pushed to a remote, migrate this
    # to a proper extraPlugins entry (buildVimPlugin + fetchFromGitHub, or
    # a `path:` flake input in the meantime) for full nix-store packaging.
    extraConfigLua = ''
      -- Only append if present: this repo is shared across hosts that
      -- don't all have the p4nvim project checked out (e.g. the Linux
      -- hosts), so guard against polluting &runtimepath with a dead path.
      local p4nvim_dir = vim.fn.expand("~/Projects/p4nvim/p4nvim")
      if vim.fn.isdirectory(p4nvim_dir) == 1 then
        vim.opt.runtimepath:append(p4nvim_dir)
      end
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>pe";
        # Lazy: require() must run at keypress time, not at keymap
        # registration during startup, since it depends on the
        # runtimepath append above having already taken effect (and
        # nixvim's generated init.lua doesn't guarantee that ordering
        # otherwise). Also guards machines without the project checked
        # out, so pressing this keymap there is a clean message instead
        # of a raw "module not found" traceback.
        action.__raw = ''
          function()
            local ok, p4nvim = pcall(require, "p4nvim")
            if not ok then
              vim.notify("p4nvim: plugin not found on this machine", vim.log.levels.WARN)
              return
            end
            p4nvim.checkout_for_edit()
          end
        '';
        options.desc = "P4: Check out current file for edit";
      }
    ];
  };
}
