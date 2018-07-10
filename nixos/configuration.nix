# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "Arcturus"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    firefox
    git
    nix-repl
    which
    bind
    ffmpeg-full
    compton
    xscreensaver
    feh
    xorg.xmodmap
  ];

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  fonts.enableFontDir = true;
  fonts.fontconfig.ultimate.enable = true;
  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  # List services that you want to enable:
  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
      enable = true;
      layout = "us";
      libinput.enable = true;
      xkbOptions = "eurosign:e";

      displayManager.gdm.enable = true;
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };

    };

    printing.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # HTPC Services
    plex.enable = true;
    sonarr.enable = true;
    couchpotato.enable = true;
    sabnzbd.enable = true;

    samba = {
        enable = true;
        securityType = "user";
        extraConfig = ''
guest account = nobody
map to guest = bad user
        '';
        enableNmbd = true;
        enableWinbindd = true;
        nsswins = true;
        shares = {
            public = { 
                browseable = "yes";
                comment = "Public samba share.";
                "guest ok" = "yes";
                path = "/media/quatro";
                "read only" = false;
            };
        };
    };
  };

  nixpkgs.config.allowUnfree = true;

  hardware = {
    opengl.driSupport32Bit = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 
      22      # SSH
      139 445 # Samba
      32400   # PLEX
      8080    # SABNzbd
      5050    # Couchpotato
      8989    # Sonarr
      6656    # Moko file share
  ];
  networking.firewall.allowedUDPPorts = [ 
      137 138 # Samba
      8080    # SABNzbd
      32400   # PLEX
  ];

  # Enable sound.
  sound.enable = true;
  sound.mediaKeys.enable = true;

  # Enable Virtualisation Config
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.mhudson = {
    createHome   = true;
    extraGroups  = [ "wheel" "video" "audio" "disk" "networkmanager" "docker" "vboxusers" ];
    group        = "users";
    home         = "/home/mhudson";
    isNormalUser = true;
    uid          = 1000;
    shell        = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.nixos.stateVersion = "18.03"; # Did you read the comment?

}
