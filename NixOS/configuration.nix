# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  user = "ppg";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.users.${user} = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.11";
    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      #autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        { 
          name = "powerlevel10k-config";
          src = ./p10k-config;
          file = "p10k.zsh";
        }
      ];
      zplug = {
        enable = true;
	plugins = [
          { name = "jeffreytse/zsh-vi-mode"; }
	];
      };
      antidote.plugins = [
        "zsh-users/zsh-autosuggestions"
        "MichaelAquilina/zsh-you-should-use"
	"zdharma-continuum/fast-syntax-highlighting"
	"belak/zsh-utils"
      ];
      shellAliases = {
        v = "nvim";
	e = "exit";
	c = "clear";
	cs = "sudo nix-store --gc";
	py = "python3";
        lg = "lazygit";
        ll = "ls -l";
	edit = "sudo nvim /etc/nixos/configuration.nix";
        update = "sudo nixos-rebuild switch";
	test = "sudo nixos-rebuild test";
      };

      history.size = 10000;
      #history.path = "${config.xdg.dataHome}/zsh/history";
      history.path = "$HOME/.zsh_history";
    };
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      historyWidgetOptions = [
        "--sort"
	"--exact"
      ];
    };
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
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        LazyVim
	nvim-treesitter 
	nvim-treesitter.withAllGrammars
	nvim-treesitter-parsers.c
      ];
      extraPackages = with pkgs; [
        python311Packages.pynvim
	python3
      ];
    };
  };

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "noiamnothere"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  #services.xserver.windowManager.qtile.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Add user to the audio and video group.
  users.extraUsers.ppg.extraGroups = ["audio"];

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      vesktop
      sdrpp
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako
    wget
    btop
    cowsay
    fortune
    neovim
    lazygit
    kitty
    xclip
    tree
    python3
    python311Packages.pip
    python311Packages.venvShellHook
    unzip
    nodejs_21
    zsh
    neofetch
    git
    rtl-sdr
    gh
    gcc
    fd
    fzf
    procps
    tmux
    ripgrep
    remmina
    syncthing
    electron
    unstable.obsidian
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
