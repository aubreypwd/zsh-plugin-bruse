#!/bin/zsh

if [[ $(command -v antigen) ]]; then
	# antigen bundle aubreypwd/zsh-plugin-require@1.0.1
	# antigen apply

	# require "brew" "" "brew"
fi

# bruse php 7.2

function bruse {
	if ! [[ -x $(command -v brew) ]]; then >&2 echo "This requires that you use Homebrew (https://brew.sh), we couldn't find the 'brew' command." && return; fi
	if ! [[ -x $(command -v xargs) ]]; then >&2 echo "This requires 'xargs' command which was not found." && return; fi

	local package="$1"
	local version="$2"

	if [[ -z $( brew ls --versions "$package@$version" ) ]]; then
		echo "$package@$version not installed, trying to install..."
		brew install "$package@$version"
	fi

	if [[ -z $( brew ls --versions "$package@$version" ) ]]; then
		echo "Unable to install or use $package@$version."
		return
	fi

	local result=$( brew link "$package@$version" --force --overwrite )

	if [[ "$result" == *"relink:"* ]]; then # Try and link the new version, unless it tells us we need to relink...
		local relink=$( echo "$result" | grep -Eo '  (.*)' ) # Get the relink command that brew is giving us.
		local relink=$( echo "$relink" | xargs ) # Trim the command.
		local relink="$relink --overwrite" # Make sure we overwrite anything.

		if [[ $relink == *"brew unlink"* ]]; then # Confirm we have an unlink command.
			echo "Linking using '$relink'..."
			eval "$relink"
		fi
	fi
}
