{ pkgs, lib, ... }:

let
  # GUI apps that come from nixpkgs rather than a cask. Spotlight and Launchpad
  # ignore symlinks into /nix/store, so these get real macOS aliases below.
  nixApps = with pkgs; [ sioyek ];
in

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

	system.activationScripts.applications.text = lib.mkForce ''
	  echo "setting up /Applications/Nix Apps..." >&2
	  rm -rf "/Applications/Nix Apps"
	  mkdir -p "/Applications/Nix Apps"
	  for src in ${lib.concatMapStringsSep " " (p: "${p}/Applications/*.app") nixApps}; do
	    [ -e "$src" ] || continue
	    ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$(basename "$src")"
	  done
	'';
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
	      "zotero"
	      "obsidian"
	      "nikitabobko/tap/aerospace"
	    ];
	  };
}
