# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "1password-gui"
      "1password"
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = ["v4l2loopback"];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  # systemd.services.bluetooth-restart-on-resume = {
  #   description = "Restart Bluetooth after suspend to fix LE HID devices";
  #   wantedBy = ["sleep.target"];
  #   after = ["sleep.target"];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.systemd}/bin/systemctl restart bluetooth.service";
  #   };
  # };
  fileSystems."/mnt/disk2" = {
    device = "/dev/disk/by-uuid/ed3f5b78-41ee-42c8-8a64-8e92b6a4a403";
    fsType = "ext4";
  };
  systemd.tmpfiles.rules = [
    "d /mnt/disk2/.Trash-1000 0700 chris users -"
    "d /mnt/disk2/.Trash-1000/files 0700 chris users -"
    "d /mnt/disk2/.Trash-1000/info 0700 chris users -"
  ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver = {
  # 	enable = true;
  # };

  xdg.mime.defaultApplications = {
    "text/html" = "vivaldi-stable.desktop";
    "x-scheme-handler/http" = "vivaldi-stable.desktop";
    "x-scheme-handler/https" = "vivaldi-stable.desktop";
  };
  power.ups = {
    enable = true;
    mode = "standalone";
    ups."UPS-1" = {
      description = "OpenUPS";
      driver = "usbhid-ups";
      port = "auto";
    };
    upsd = {
      listen = [
        {
          address = "127.0.0.1";
          port = 3493;
        }
      ];
    };
    users."nut-admin" = {
      passwordFile = "/etc/nixos/hosts/portadeck/ups-passwd.txt";
      upsmon = "primary";
    };
    upsmon.monitor."UPS-1" = {
      system = "UPS-1@localhost";
      powerValue = 1;
      user = "nut-admin";
      passwordFile = "/etc/nixos/hosts/portadeck/ups-passwd.txt";
      type = "primary";
    };
    upsmon.settings = {
      NOTIFYMSG = [
        ["ONLINE" ''"UPS %s: Online power."'']
      ];
    };
  };
  imports = [
    ./hardware-configuration.nix
    ../../modules/nix-settings.nix
    ../../modules/apps.nix
    ../../modules/common.nix
    ../../modules/desktop.nix
    ../../modules/gaming.nix
    ../../modules/networking.nix
    ../../modules/peripherals.nix
    ../../modules/services.nix
    ../../modules/users.nix
    ../../modules/virtualization.nix
    ../../modules/nvim
  ];
  networking.hostName = "portadeck";
  # Configure keymap in X11

  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
