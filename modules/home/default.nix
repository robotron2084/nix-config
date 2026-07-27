{pkgs, ...}: {
  home.username = "chris";
  home.homeDirectory = "/home/chris";

  home.stateVersion = "25.11";
  home.sessionVariables = {
    PATH = "$PATH:$HOME/.local/bin";
  };

  imports = [
    ./bash.nix
    (import ./niri {inherit pkgs;})
    ../noctalia
  ];
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
  };

  home.packages = with pkgs; [
    nnn
    zip
    xz
    unzip
    bc

    ripgrep
    jq
    eza
    fzf
    dua
    bat

    cowsay
    tree
    btop
    rmpc
    gnome-font-viewer
    rustup
    xwayland-satellite
    ffmpeg-full
    blender
    playerctl
    brightnessctl
    iftop
    wl-clipboard
    tenacity
    xnconvert
    krita
    inkscape
    feh
    wev
    kdePackages.kdenlive
    vlc
    yazi
    hledger
    hledger-ui
    hledger-web
    hledger-fmt
    terraform
    awscli2
    qalculate-qt
    darktable
    picard
    fastfetch
    claude-code
  ];

  programs.direnv.enable = true;

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.padding = {
      x = 4;
      y = 4;
    };
  };

  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      background-opacity = "0.6";
      font-family = "Hurmit Nerd Font Mono";
    };
  };

  programs.lazygit = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    useTheme = "powerlevel10k_rainbow";
  };
  services.polkit-gnome.enable = true;

  programs.git = {
    enable = true;
    settings.user.email = "Chris Hill";
    settings.user.name = "chris@enemyhideout.com";
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
    ];
  };
  services.mpd = {
    enable = true;
    musicDirectory = "/home/chris/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
    # Optional:
    # network.listenAddress = "any"; # if you want to allow non-localhost connections
    # network.startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };

  services.mpd-mpris.enable = true;

  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      # program_options = {
      #     # replace with your favorite file manager
      #     file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
      # };
    };
  };
  home.file."Pictures/Wallpapers".source = ./wallpapers;

  # This has a dependency on python 3 and requires running
  # python3 -m pip install -U "yt-dlp[default]"
  # to get the latest python.
  home.file."bin/dl-yt".source = ./bin/dl-yt;
  home.file."bin/dl-pl".source = ./bin/dl-pl;
}
