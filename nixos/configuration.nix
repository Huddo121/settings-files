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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Antares"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enabled = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget vim firefox git nix-repl which xscreensaver htop
    bind # Tools like dig
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
  ];

  # List services that you want to enable:

  services = {
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

  # Open ports in the firewall.
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 
      22 # SSH
      139 445 # Samba
      32400 # PLEX
      8080 # SABNzbd
      5050 # Couchpotato
      8989 # Sonarr
      6656 # Moko file share
  ];
  networking.firewall.allowedUDPPorts = [ 
      137 138 # Samba
      8080    # SABNzbd
      32400   # PLEX
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    displayManager.gdm.enable = true;

    desktopManager = {
      gnome3.enable = true;
      default = "gnome3";
    };
  };

  nixpkgs.config.allowUnfree = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.mhudson = {
    createHome = true;
    extraGroups = ["wheel" "video" "audio" "disk" "docker" "vboxusers"];
    group = "users";
    home = "/home/mhudson";
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

  # Enable Virtualisation Config
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;

  # Audio Options
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = true;

  # Set up ZSH
  environment.shells = [ pkgs.zsh ];
  programs.zsh.interactiveShellInit = ''
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

    # Customize your oh-my-zsh options here
    ZSH_THEME="agnoster"
    plugins=(git)

    source $ZSH/oh-my-zsh.sh
  '';

  programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh
  programs.zsh.ohMyZsh = {
    enable = true;
  };
}
