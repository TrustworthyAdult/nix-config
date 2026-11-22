{
	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

	outputs = { nixpkgs, ... }: {
		nixosConfigurations.zeus = nixpkgs.lib.nixosSystem {
			modules = [ ./hosts/zeus ];
		};
	};
}
