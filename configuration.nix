
# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use UEFI/GRUB
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;

  # LVM inclusion so GRUB doesn't complain
  boot.initrd.services.lvm.enable = true;  

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Define your hostname.
  networking.hostName = "nixos";

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Sets your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
     font = "Lat2-Terminus16";
     useXkbConfig = true; # use xkb.options in tty.
   };

  # Enable the X11 windowing system.
  services.xserver = {
     enable = true;
     layout = "br";
     xkbVariant = "abnt2";     

     windowManager.i3.enable = true;
     displayManager.defaultSession = "none+i3";
  };

  # Enable i3 as WM
  services.xserver.xkb.layout = "br";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support 
  services.libinput.enable = true;

   users.users.paz = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ];
     packages = with pkgs; [
       tree
     ];
   };

  environment.sessionVariables = {
     EDITOR = "nvim";
     VISUAL = "nvim";
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     neovim 
     wget
     rofi
     i3
     rofi
     i3blocks
     picom
     alacritty
     dunst
     pcmanfm
     lxappearance
     arandr 
     flameshot
     librewolf # browser
     git
     htop
     fastfetch
     keepassxc # password manager
     xclip # x11 clipboard
     feh # wallpapers
     tldr # user manpages
     yazi # cli file manager
     pywal # wallpaper based color candy
   ];

   fonts.packages = with pkgs; [
     # noto fonts for universal fallback and emojis
     noto-fonts
     noto-fonts-cjk-sans
     noto-fonts-color-emoji

     # monospace fonts
     jetbrains-mono
     #dejavu-fonts
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # Enable the OpenSSH daemon.
  services.openssh = {
     enable = true;
     settings = {
       PasswordAuthentication = true;
       PermitRootLogin = "no";
     };
  };

  # Git setup
  programs.git = {
     enable = true;
     config = {
        user.name = "yourname";
        user.email = "youremail@example.com";
     };
  }; 
  

  # Open SSH port in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

