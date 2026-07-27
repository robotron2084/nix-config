{pkgs, ...}: {
  users.users.chris = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "adbusers" "docker" "scanner" "lp" "dialout"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = ["chris"];
  };
  users.groups.libvirtd.members = ["chris"];
}
