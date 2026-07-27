{
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>wr";
        action = "<cmd>AutoSession restore<CR>";
        options.desc = "Restore Session for CWD";
      }
      {
        key = "<leader>ws";
        action = "<cmd>AutoSession save<CR>";
        options.desc = "Save Session for CWD";
      }
    ];
  };

  programs.nixvim.plugins.auto-session = {
    enable = true;
    settings = {
      auto_restore_enabled = true;
      auto_session_suppress_dirs = [
        "~/"
        "~/Downloads"
        "~/git"
      ];
    };
  };
}
