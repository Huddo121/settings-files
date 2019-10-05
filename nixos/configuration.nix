# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Pick which kernel to run. Need a newer one for Ryzen.
  boot.kernelPackages = pkgs.linuxPackages_5_2;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "Altair";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  powerManagement.enable = false;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    which
    bind
    ffmpeg-full
    exfat
    ntfs3g

    # Desktop/WM stuff
    compton
    xscreensaver
    feh
    xorg.xmodmap
    (polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    })
    flameshot
    rofi

    xfce.xfce4-taskmanager
    xfce.xfce4-power-manager

    google-chrome
  ];

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jdk;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;

  fonts.enableFontDir = true;
  fonts.fontconfig.ultimate.enable = true;
  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome-ttf
    material-icons
    source-code-pro
  ];

  # Set up the external drives to be mounted
  fileSystems.quatro = {
    device = "/dev/sda1";
    mountPoint = "/media/quatro";
    fsType = "ntfs-3g";
    label = "Quatro";
  };

  fileSystems.uno = {
    device = "/dev/sdb1";
    mountPoint = "/media/uno";
    label = "Uno";
  };

  fileSystems.medio = {
    device = "/dev/sdd1";
    mountPoint = "/media/medio";
    label = "Medio";
  };


  # List services that you want to enable:
  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
      enable = true;
      layout = "us";
      libinput.enable = true;
      xkbOptions = "caps:hyper";

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };

      desktopManager = {
        default = "xfce";
        xterm.enable = false;
        xfce ={
          enable = true;
          noDesktop = true;
	  thunarPlugins = [ pkgs.xfce.thunar-archive-plugin ];
          enableXfwm = false;
        };

        gnome3 = {
          enable = true;
        };
      };

      displayManager.lightdm = {
        enable = true;
        greeter.enable = true;
        greeters.enso = {
          enable = true;
          blur = true;
        };
      };
    };

    gnome3 = {
      evolution-data-server.enable = true;
      file-roller.enable = true;
      gnome-disks.enable = true;
      gnome-documents.enable = true;
      gnome-keyring.enable = true;
      gvfs.enable = true;
      seahorse.enable = true;
      sushi.enable = true;
      tracker-miners.enable = true;
      tracker.enable = true;
    };
 
    compton = {
      enable = true;
      backend = "glx";
      vSync = true;
      refreshRate = 60;
      opacityRules = [
        "85:class_g = 'kitty' && !_NET_WM_STATE@:32a"
        "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      ];

      shadow = true;
      shadowOpacity = "0.33";
      shadowOffsets = [ (-10) 0 ];
      shadowExclude = [ "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'" ];

      fade = true;
      fadeDelta = 2;

      settings = {
        no-dnd-shadow = true;
        no-dock-shadow = true;
        clear-shadow = true;
        shadow-radius = 5;
      };

    };

    dbus.packages = [ pkgs.flameshot ];

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
            uno = {
              browseable = "yes";
              comment = "Uno";
              "guest ok" = "yes";
              path = "/media/uno";
              "read only" = false;
            };
        };
    };

    # Games
    minecraft-server = {
      enable = true;
      eula = true;
      openFirewall = true;
      declarative = true;
      serverProperties = {
        motd = "Megaman fun times";
        difficulty = "normal";
        level-name = "megaman";
        level-seed = "megaman";
        view-distance = 18;
      };
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
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
      25565   # Minecraft
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
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "mhudson" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.mhudson = {
    createHome   = true;
    extraGroups  = [ "wheel" "video" "audio" "disk" "networkmanager" "docker" ];
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
  system.stateVersion = "20.03"; # Did you read the comment?

}
