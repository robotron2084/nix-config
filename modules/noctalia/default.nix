{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];
  programs.noctalia = {
    enable = true;
    settings = ./noctalia_config.toml;
  };
}
