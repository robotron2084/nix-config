{pkgs, ...}: {
  hardware.keyboard.qmk.enable = true;
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [pkgs.sane-airscan];
  services.udev.packages = with pkgs; [via pkgs.sane-airscan];
  services.udisks2.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.blueman.enable = true;
  # Enable the IPP Everywhere protocol to detect printers.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };
}
