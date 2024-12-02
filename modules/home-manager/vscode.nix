{ pkgs, lib, config, ... }: {

  options = {
    vscode.enable = lib.mkEnableOption "Enables and configures vscode with extensions.";
  };

  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        vscodevim.vim
        enkia.tokyo-night
      ];
    };
  };
}
