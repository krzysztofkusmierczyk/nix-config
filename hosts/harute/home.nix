{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  imports = [
    ../../modules/home-manager
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tetius";
  home.homeDirectory = "/home/tetius";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  slack.enable = true;
  vscode.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.git = {
    enable = true;
    userName = "Krzysztof Kuśmierczyk";
    userEmail = "11976750+krzysztofkusmierczyk@users.noreply.github.com";

    extraConfig = {
      init = {defaultBranch = "main";};
      pull = {rebase = false;};
      rerere = {enabled = true;};
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = {
        gpgsign = true;
      };
      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAa8Q426U08D7RxoGXDQuhV07i30YKUxhGavJeEZghF9";
      };
      # core = { editor = vnim; };
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = "source ${./dotfiles/functions}";
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "docker" "docker-compose" "pyenv"];
      theme = "agnoster";
    };
  };

  home.shellAliases = {
    ll = "ls -l";
    la = "ls -la";
    update = "sudo nixos-rebuild switch --flake ~/nix-config";
    cdp = "cd ~/proj";
    gai = "git add -i"; # TODO: only enable when git installed
    gbDa = "git branch | grep -v develop | grep -v master | grep -v main | xargs git branch -D"; # TODO only enable when git is installed

    # TODO only enable when docker is installed
    dknukev = "docker volume rm $(docker volume ls -q)";
    dknuke = "docker kill $(docker ps -q) ; docker system prune -af --volumes ; docker volume rm $(docker volume ls -q)";
    lzd = "lazydocker";
    dkps = "docker ps";

    # TODO only when assume is installed
    assume = "source assume";

    get_uuid = "python -c 'import uuid; print(uuid.uuid4())'"; # TODO only when python installed
  };

  programs.wezterm = {
    enable = true;
  };
  xdg.configFile."wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/hosts/harute/dotfiles/wezterm.lua";

  xdg.configFile."autostart/steam.desktop" = {
    enable = osConfig.steam.enable;
    text = ''
      [Desktop Entry]
      Name=Steam
      Exec=steam -silent %U
      Icon=steam
      Terminal=false
      Type=Application
      Categories=Network;FileTransfer;Game;
      MimeType=x-scheme-handler/steam;x-scheme-handler/steamlink;
      Actions=Store;Community;Library;Servers;Screenshots;News;Settings;BigPicture;Friends;
      PrefersNonDefaultGPU=true
      X-KDE-RunOnDiscreteGpu=true
    '';
  };

  xdg.configFile."autostart/1password.desktop" = {
    enable = osConfig.one-password.enable;
    text = ''
      [Desktop Entry]
      Categories=Office;
      Comment=Password manager and secure wallet
      Exec=1password --silent %U
      Icon=1password
      MimeType=x-scheme-handler/onepassword;
      Name=1Password
      StartupWMClass=1Password
      Terminal=false
      Type=Application
    '';
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {};

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tetius/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NVM_DIR = "$HOME/.nvm";
    COMPOSE_DOCKER_CLI_BUILD = 1;
    DOCKER_BUILDKIT = 1;
    GRPC_PYTHON_BUILD_SYSTEM_OPENSSL = 1;
    GRPC_PYTHON_BUILD_SYSTEM_ZLIB = 1;
    PAGER = "less -S"; # pgsql don't wrap select output
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
