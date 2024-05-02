# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./hypr/hypr.nix
  ];

  nixpkgs = {
    # You can add overlays here
    # overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    # ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # This probably does not solve my problems but here we go I guess.
  hypr.enable = true;
  
  home = {
    username = "meidoragon";
    homeDirectory = "/home/meidoragon";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # Add stuff for your user as you see fit:
  # home.packages = with pkgs; [ steam ];
  # home.packages = with pkgs; [waybar];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "meidoragon";
    userEmail = "104027002+Meidoragon@users.noreply.github.com";
  };
  programs.neovim.enable = true;
  programs.vim.enable = true;
  programs.alacritty.enable = true;
  programs.zellij.enable = true;


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
