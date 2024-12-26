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
    home.packages = [
      pkgs.neovim
      
      # unnamedplus clipboarf support. See :help clipboard
      pkgs.wl-clipboard
      pkgs.xclip
      
      # LSPs
      pkgs.lua-language-server
    ];

    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/modules/home-manager/neovim/nvim";
      recursive = true;
    };
  };
}
