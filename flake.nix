{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs-unstable = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#Momo'
    nixosConfigurations = {
      Momo = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          ./nixos/configuration.nix
          #home-manager.nixosModules.home-manager
          #{
            # home-manager.useGlobalPkgs = true;
            #home-manager.useUserPackages = true;
            #home-manager.users.meidoragon = import ./home-manager/home.nix;
          #}
        ];
      };
    };

    # this currently does nothing because home-manager is not installed by the system?
    # but we import it up there so it's fine probably
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#meidoragon@Momo'
    homeConfigurations = {
      "meidoragon@Momo" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [
	  hyprland.homeManagerModules.default
	  {wayland.windowManager.hyprland.enable = true;}
	  ./home-manager/home.nix
	];
      };
    };
  };
}
