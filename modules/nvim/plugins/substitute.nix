{
  programs.nixvim = {
    plugins.substitute.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "s";
        action.__raw = ''require('substitute').operator'';
        options.desc = "Substitute With Motion";
      }
      {
        mode = "n";
        key = "ss";
        action.__raw = ''require('substitute').line'';
        options.desc = "Substitute Line";
      }
      {
        mode = "n";
        key = "S";
        action.__raw = ''require('substitute').eol'';
        options.desc = "Substitute To End Of Line";
      }
      {
        mode = "x";
        key = "s";
        action.__raw = ''require('substitute').visual'';
        options.desc = "Substitute In Visual Mode";
      }
    ];
  };
}
