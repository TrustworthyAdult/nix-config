{
	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	inputs.wrappers.url = "github:nix-community/nix-wrapper-modules";

	outputs = { nixpkgs, ... }@inputs: {
		nixosConfigurations.zeus = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [ ./hosts/zeus ];
		};
	};
}
