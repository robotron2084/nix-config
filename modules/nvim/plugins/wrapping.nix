{
  programs.nixvim.plugins.wrapping = {
    enable = true;
    settings = {
      auto_set_mode_filetype_allowlist = [
        "asciidoc"
        "gitcommit"
        "latex"
        "mail"
        "markdown"
        "rst"
        "tex"
        "text"
        "txt"
        "cs"
      ];
      softener.cs = true;
      softener.text = true;
    };
  };
}
