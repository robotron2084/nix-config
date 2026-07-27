{
  description = "Portadeck Flake";

  nixConfig = {
    extra-substituters = [
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixvim,
    ...
  }: let
    system = "x86_64-linux";
  in {
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    nixosConfigurations.portadeck = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs system;};
      modules = [
        {nixpkgs.config.allowUnfree = true;}
        nixvim.nixosModules.nixvim
        ./hosts/portadeck
        # make home-manager as a module of nixos
        # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };

          home-manager.users.chris = {
            imports = [
              ./modules/home
              # specific home-manager items for this machine (ex: wallpaper)
              ./hosts/portadeck/home.nix
            ];
          };
        }
      ];
    };
    nixosConfigurations.silversurfer = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs system;};
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        {nixpkgs.config.allowUnfree = true;}
        nixvim.nixosModules.nixvim
        ./hosts/silversurfer

        # make home-manager as a module of nixos
        # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };

          home-manager.users.chris = {
            imports = [
              ./modules/home
              ./hosts/silversurfer/home.nix
            ];
          };
          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
      ];
    };
    nixosConfigurations.threeofone = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs system nixpkgs-unstable;};
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        {nixpkgs.config.allowUnfree = true;}
        nixvim.nixosModules.nixvim
        ./hosts/threeofone

        # make home-manager as a module of nixos
        # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };

          home-manager.users.chris = {
            imports = [
              ./modules/home
              ./hosts/threeofone/home.nix
            ];
          };
          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
      ];
    };

    homeConfigurations."macbook" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      extraSpecialArgs = {inherit inputs;};
      modules = [
        nixvim.homeModules.nixvim
        ./modules/home-darwin
      ];
    };
  };
}
