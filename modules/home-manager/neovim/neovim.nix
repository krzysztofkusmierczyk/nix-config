{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    neovim.enable = lib.mkEnableOption "Enables neovim.";
  };

  config = lib.mkIf config.neovim.enable {
    home.packages = [pkgs.neovim];
    xdg.configFile."nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/home-manager/neovim/files/init.lua";
  };
}
