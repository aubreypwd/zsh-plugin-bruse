#!/bin/zsh

###
 # Install version specified in .bruse.json.
 #
 #     {
 #       "node": "10",
 #       "php": "7.2"
 #     }
 #
 # E.g. this will:
 #
 #     bruse node@10
 #     bruse php@7.2
 #
 # @since 1.1.0
 ##
function bruse_json() {

	if ! [[ -f ".bruse.json" ]]; then
		return
	fi

	local package=0

	for package in $( jq -r 'keys | .[]' '.bruse.json' ); do
		local version=$( jq -r ".$package" '.bruse.json' | xargs );

		bruse $(echo "$package" | xargs) "$version"
	done
}

###
 # Detect version of node in .nvmrc.
 #
 # If a version is specified in a .nvmrc file, it will
 # try and automatically install that version.
 #
 # @since 1.1.0
 ##
function bruse_nvmrc() {
	if ! [[ -x $(command -v xargs) ]]; then
		return;
	fi

	if ! [[ -f ".nvmrc" ]]; then
		return;
	fi

	local version=$(cat .nvmrc | xargs)

	bruse node "$version"
}

###
 # Bruse
 #
 # E.g: bruse php 7.4
 #
 # @since 1.0.0
 # @since 10/2/20
 #
 # @author Aubrey Portwood <aubrey@webdevstudios.com>
 ##
function bruse {
	if [[ "" = "$1" ]]; then
		bruse_nvmrc

		if [[ -x $(command -v jq) ]]; then
			bruse_json
			return
		fi

		echo "Install jq () for .bruse.json and .nvmrc support."
		return;
	fi

	if ! [[ -x $(command -v brew) ]]; then >&2 echo "This helps out Homebrew (https://brew.sh), we couldn't find the 'brew' command." && return; fi
	if ! [[ -x $(command -v xargs) ]]; then >&2 echo "This requires 'xargs' command which was not found." && return; fi

	local package=$( echo "$1" | xargs )
	local version=$( echo "$2" | xargs )

	echo "\nUsing $package@$version..."

	if [[ -z $( brew ls --versions "$package@$version" ) ]]; then
		echo " - Not installed, trying to install..."
		brew install "$package@$version"
	fi

	if [[ -z $( brew ls --versions "$package@$version" ) ]]; then
		echo "- Unable to install or use $package@$version."
		return
	fi

	local try_link_results=$( brew link "$package@$version" --force --overwrite )

	if [[ "$try_link_results" == *"relink:"* ]]; then # Try and link the new version, unless it tells us we need to relink...
		local relink_command=$( echo "$try_link_results" | grep -Eo '  (.*)' ) # Get the relink command that brew is giving us.
		local relink_command=$( echo "$relink_command" | xargs ) # Trim the command.
		local relink_command="$relink_command --overwrite" # Make sure we overwrite anything.

		if [[ $relink_command == *"brew unlink"* ]]; then # Confirm we have an unlink command.
			echo "- Linking using '$relink_command'..."
			eval "$relink_command"
		fi
	fi
}
