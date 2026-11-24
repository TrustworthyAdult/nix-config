{ inputs, ... }:
{
	imports = [ inputs.wrappers.nixosModules.ghostty ];

	wrappers.ghostty = {
		enable = true;
		settings.theme = "Atom One Dark";
	};
}
