# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# To switch this config to main nixos config run the command below
# sudo nixos-rebuild switch -I nixos-config=/home/ppg/DotFiles/NixOS/configuration.nix

{ config, pkgs, lib, ... }:
let
  # Add home-manager 23.11 to configuration.nix
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";

  # Run the commands below before updating config
  # sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  # sudo nix-channel --update
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

  #xfce xfconf package
  xfconf = pkgs.xfce.xfconf;

  # Change to your user and hostname here
  user = "ppg";
  hostname = "noiamnothere";
in
{
  # Importing hardware configuration and home-manager
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # Allow flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # home-manager configurations
  home-manager.users.${user} = {
    home.stateVersion = "23.11";


    # Application configurations below

    # rofi -show drun
    programs.rofi = {
      enable = true;
    };
    home.file.".config/rofi" = {
      source = /home/${user}/DotFiles/NixOS/rofi;
      recursive = true;
      executable = true;     
    };

    # zsh configurations
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          # powerlevel10k config location in DotFiles
          name = "powerlevel10k-config";
          src = /home/${user}/DotFiles/NixOS;
          file = "p10k.zsh";
        }
      ];
      zplug = {
        enable = true;
        plugins = [
          { name = "agkozak/zsh-z"; }
          { name = "belak/zsh-utils"; }
          { name = "jeffreytse/zsh-vi-mode"; }
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "MichaelAquilina/zsh-you-should-use"; }
          { name = "zdharma-continuum/fast-syntax-highlighting"; }
        ];
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "bgnotify"
          "python"
        ];
      };
      shellAliases = {
        v = "nvim";
        e = "exit";
        c = "clear";
        cs = "sudo nix-store --gc";
        py = "python";
        lg = "lazygit";
        ll = "ls -l";
        test = "sudo nixos-rebuild test";
        edit = "sudo nvim /etc/nixos/configuration.nix";
        update = "sudo nixos-rebuild switch";
      };
      history.size = 10000;
      history.path = "/home/${user}.zsh_history";
    };

    # Set location for nvim config to DotFiles repo in home directory
    home.file.".config/nvim" = {
      source = /home/${user}/DotFiles/NixOS/nvim;
      recursive = true;
      executable = true;
    };

    # Add fuzzy finder integration
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      historyWidgetOptions = [
        "--sort"
        "--exact"
      ];
    };

    # Kitty configuration
    # https://sw.kovidgoyal.net/kitty/conf/
    programs.kitty = {
       enable = true;
       theme = "Catppuccin-Mocha";
       shellIntegration.enableZshIntegration = true;
       settings = {
         font_family = "JerBrainsMono Nerd Font Mono";
         font_size = 12;
         force_ltr = false;
         disable_ligatures = "cursor";
         cursor_shape = "beam";
         cursor_blink_interval = 0;
         inactive_text_alpha = "0.8";
         tab_bar_edge = "top";
         tab_bar_style = "powerline";
         background_opacity = "0.85";
         sync_to_monitor = true;
         shell = ".";
         enable_audio_bell = false;
       };
       extraConfig = "
         map ctrl+shift+n new_os_window_with_cwd
         map f2 launch --cwd=current --type=tab
         map ctrl+shift+t new_tab_with_cwd
         map ctrl+j next_window
         map ctrl+k previous_window
         map ctrl+; combine : clear_terminal scrollback active : send_text normal,application \x0c
       ";
    };
  };

  # Bootloader.
  # If you would like to have systemd-boot uncomment that line and comment out Grub lines.
  boot.loader = {
    # Systemd boot
    #systemd-boot.enable = true;

    # EFI settings 
    efi.canTouchEfiVariables = true;
    
    # Grub configuration
    grub.enable = true;
    grub.device = "nodev";
    grub.efiSupport = true;
    grub.useOSProber = true;
  };

  # Setting Hostname
  networking.hostName = "${hostname}"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure xserver
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    
    # Display Manager 
    displayManager = {
      lightdm.enable = true;
    };
    # Desktop Manager
    desktopManager.xfce = {
      enable = true;
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Add user to the audio and video group.
  users.extraUsers.${user}.extraGroups = ["audio"];

  # Enable full Pulse Audio package
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
  #  support32Bit = true;
  };
  sound.mediaKeys = {
    enable = true;
    volumeStep = "5%";
  };
  services.actkbd = {
    enable = true;
    # Fix for lenovo T15 volume buttons
    bindings = [
      { keys = [ 113 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l ${user} -c 'amixer -q set Master toggle'"; }
      { keys = [ 114 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l ${user} -c 'amixer -q set Master 5%- unmute'"; }
      { keys = [ 115 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l ${user} -c 'amixer -q set Master 5%+ unmute'"; }
    ];
  };
  
  # Enable real audio
  security.rtkit.enable = true; 

  # Enable zsh as main shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Install Nerd Font
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      vesktop
      neovim
      sdrpp
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Programming
    gcc
    nodejs_21
    tree-sitter
    # unstable python3 require for latest version of pynvim still works with stable
    (unstable.python3.withPackages (ps: with ps; [
      pip
      pynvim
    ]))

    # Drivers
    rtl-sdr

    # Clipboards
    xclip
    wl-clipboard

    # Terminal
    zsh
    tmux
    kitty

    # Productivity
    gh
    fd
    fzf
    git
    wget
    rofi
    unzip
    procps
    ripgrep
    remmina
    lazygit
    electron
    syncthing
    unstable.obsidian

    # Misc
    tree
    grim
    mako
    slurp

    # Fun
    btop
    cowsay
    fortune
    neofetch
    tty-solitaire
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
