{...}: {
  services = {
    syncthing = {
      enable = true;
      group = "users";
      user = "chris";
      dataDir = "/home/chris/Downloads"; # Default folder for new synced folders
      configDir = "/home/chris/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
    flatpak.enable = true;
    tailscale.enable = true;
  };
  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
