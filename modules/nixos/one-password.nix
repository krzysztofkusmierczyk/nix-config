{ pkgs, lib, config, ... }: {

  options = {
    one-password.enable = lib.mkEnableOption "Enable 1password.";
  };

  config = lib.mkIf config.one-password.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "tetius" ];
    };
  };
}
