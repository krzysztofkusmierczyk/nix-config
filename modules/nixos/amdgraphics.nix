{ pkgs, lib, config, ... }: {

  options = {
    amdgraphics.enable = lib.mkEnableOption "Enables AMD graphic drivers";
  };

  config = lib.mkIf config.amdgraphics.enable {
    services.xserver.videoDrivers = [ "amdgpu" ];
    boot.initrd.kernelModules = [ "amdgpu" ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
