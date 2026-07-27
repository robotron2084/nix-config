{...}: {
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  networking.networkmanager.ensureProfiles.profiles = {
    chingona_5g = {
      connection = {
        id = "chingona_5g";
        autoconnect-priority = 10;
        type = "wifi";
      };
    };
    chingona = {
      connection = {
        id = "chingona";
        autoconnect-priority = 0;
        type = "wifi";
      };
    };
  };
}
