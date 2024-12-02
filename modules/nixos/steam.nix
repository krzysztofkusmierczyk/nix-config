{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    steam.enable = lib.mkEnableOption "Enables steam client and other tools.";
  };

  config = lib.mkIf config.steam.enable {
    environment.systemPackages = with pkgs; [
      protonup
    ];
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/tetius/.steam/root/compatibilitytools.d";
    };
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;
  };
}
