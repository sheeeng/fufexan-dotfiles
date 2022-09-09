{
  pkgs,
  config,
  ...
}:
# media - control and enjoy audio/video
{
  imports = [
    ./spicetify.nix
  ];

  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer
    # images
    imv

    spotify-tui
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };

    obs-studio.enable = true;
  };

  services = {
    easyeffects.enable = true;
    playerctld.enable = true;
    spotifyd = {
      enable = true;
      package = pkgs.spotifyd.override {withMpris = true;};
      settings.global = {
        autoplay = true;
        backend = "pulseaudio";
        bitrate = 320;
        cache_path = "${config.xdg.cacheHome}/spotifyd";
        device_type = "computer";
        password_cmd = "tail -1 /run/agenix/spotify";
        use_mpris = true;
        username_cmd = "head -1 /run/agenix/spotify";
        volume_normalisation = true;
      };
    };
  };
}
