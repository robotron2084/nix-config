{pkgs, ...}: {
  services = {
    xserver.enable = true;
    xserver.xkb.options = "ctrl:nocaps";
    greetd = {
      enable = true;

      settings = {
        default_session = {
          command = ''
            ${pkgs.tuigreet}/bin/tuigreet \
              --time \
              --remember \
              --cmd niri-session
          '';
          user = "greeter";
        };
      };
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
    nerd-fonts.hurmit
  ];
}
