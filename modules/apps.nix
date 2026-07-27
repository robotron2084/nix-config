{
  pkgs,
  nixpkgs-unstable,
  ...
}: let
  pkgsUnstable = import nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    alacritty
    git
    fuzzel
    signal-desktop
    dnslookup
    bibata-cursors
    gcc
    discord-ptb
    alejandra
    pciutils
    usbutils
    cifs-utils
    yt-dlp
    vivaldi
    kitty
    killall
    nautilus
    via
    simple-scan
    exfatprogs
    easyeffects
    dotnet-sdk
    joycond
    opencode
    llmfit
    uv
    python3
  ];
  programs.firefox.enable = true;
  programs.niri.enable = true;
  programs._1password.enable = true;
}
