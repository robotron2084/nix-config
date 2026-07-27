{
  pkgs,
  lib,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      nv = "cd ~/nixos; nvim";
      ns = "sudo rsync -a --delete ~/nixos/ /etc/nixos/ && cd /etc/nixos && sudo nixos-rebuild switch --flake";
      ls = "eza --icons=always";
      vim = "nvim";
      v = "nvim";
      cd = "z";
      y = "yazi";
      nixgc = "sudo nix-collect-garbage -d";
      sync-music = "rsync -ai /home/chris/Music/ /run/media/chris/MyMusic/";
      mntshare = "sudo mount.cifs -o sec=ntlmssp,credentials=/home/chris/media/smb-secrets,uid=1000,gid=100 //192.168.x.x/share ~/media/share";
      mntmusic = "sudo mount.cifs -o sec=ntlmssp,credentials=/home/chris/media/smb-secrets,uid=1000,gid=100 //192.168.x.x/music ~/media/music";
      mntpaola = "sudo mount.cifs -o sec=ntlmssp,credentials=/home/chris/media/smb-secrets-paola,uid=1000,gid=100 //192.168.x.x/paola ~/media/paola";
    };
  };
}
