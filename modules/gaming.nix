{...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Essential for Steam's 32-bit components
  };
  programs.steam.enable = true;
}
