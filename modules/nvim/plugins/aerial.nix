{
  programs.nixvim = {
    keymaps = [
      {
        key = "{";
        action = "<cmd>AerialPrev<CR>";
        options.desc = "Previous Symbol (Aerial)";
      }
      {
        key = "}";
        action = "<cmd>AerialNext<CR>";
        options.desc = "Next Symbol (Aerial)";
      }
      {
        key = "<leader>a";
        action = "<cmd>AerialToggle<CR>";
        options.desc = "Toggle Aerial Outline";
      }
    ];
  };
  programs.nixvim.plugins.aerial = {
    enable = true;
  };
}
