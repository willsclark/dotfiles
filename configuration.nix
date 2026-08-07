{...}:

{
# Determinate already manages the Nix daemon, so nix-daemon shouldn't
nix.enable = false;

nixpkgs.config.allowUnfree = true;
nixpkgs.hostPlatform = "aarch64-darwin";

system.primaryUser = "willclark";
users.users.willclark = {
   home = "/Users/willclark";
};
system.stateVersion = 6;

system.defaults = {
	NSGlobalDomain = {
		AppleInterfaceStyle = null;
		KeyRepeat = 2;
		InitialKeyRepeat = 15;
		_HIHideMenuBar = true;
		AppleShowAllExtensions = true;
};
	dock.autohide = true;
	finder.FXPreferredViewStyle = "Nlsv"; # list view by default
	finder.CreateDesktop = false;
	trackpad.Clicking = true;
};
	nix-homebrew = {
	    enable = true;
	    user = "willclark";
	  };
	  homebrew = {
	    enable = true;
	    onActivation.cleanup = "zap";  # remove anything not listed here
	    onActivation.autoUpdate = true;
	    onActivation.extraFlags = [ "--force" ];
	    brews = [
	      "herdr"
	      "fx"
	      "uv"
	      "jupytext"
	      "node"
	      "jupyterlab"
	    ];
	    casks = [
	      "ghostty"
	      "claude-code"
	      "discord"
	    ];
	  };
}
