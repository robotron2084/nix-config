{...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  # Set your time zone.
  time.timeZone = "America/Phoenix";
  security.polkit.enable = true;
  powerManagement.enable = true;
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=30
  '';
}
