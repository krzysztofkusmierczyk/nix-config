{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    slack.enable = lib.mkEnableOption "Enables slack.";
  };

  config = lib.mkIf config.slack.enable {
    home.packages = [pkgs.slack];
    xdg.configFile."autostart/slack.destkop" = {
      text = ''
        [Desktop Entry]
        Name=Slack
        Categories=Network;InstantMessaging;
        Comment=Slack Desktop
        Exec=slack --startup --silent %U
        GenericName=Slack Client for Linux
        Icon=slack
        MimeType=x-scheme-handler/slack;
        StartupNotify=true
        StartupWMClass=Slack
        Type=Application
      '';
    };
  };
}
