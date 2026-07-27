{pkgs, ...}: {
  virtualisation.docker.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [virtiofsd];
}
