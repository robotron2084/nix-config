{
  inputs,
  pkgs,
  ...
}: {
  home.username = "chris";
  home.homeDirectory = "/Users/chris";
  home.stateVersion = "25.11";

  imports = [
    ../nvim
  ];

  home.packages = [
    pkgs.stylua
    pkgs.lua51Packages.luacheck
  ];

  programs.home-manager.enable = true;
}
