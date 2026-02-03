if status is-interactive
	# Source Nix.
	source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish

	# Disable greeting.
	set -U fish_greeting

	# Add items to PATH.
	fish_add_path $HOME/.local/node_packages/node_modules/.bin
	
	# Set environment variables.
	if command --search nvim > /dev/null
		set -gx EDITOR nvim
	else
		set -gx EDITOR vim
	end

	set -gx VIRTUAL_ENV_DISABLE_PROMPT false

	# Set aliases.
	alias md='mkdir'

	if command --search bat > /dev/null
		alias cat='bat'
	end

	if command --search eza > /dev/null
		alias ls='eza'
		alias l='eza -l'
		alias la='eza -al'
		alias tree='eza --tree'
		alias treegi='eza --tree --git-ignore'
	end

	if command --search git > /dev/null
		alias g='git'
		alias gs='git status'
		alias gc='git commit'
		alias gba='git branch -a'
		alias gpl='git pull'
		alias gpu='git push'
		alias gwt='git worktree'
		alias gui='gitui'
		alias cdr='cd $(git rev-parse --show-toplevel)'
		alias diff='git diff --no-index'
	end

	if command --search podman > /dev/null
		alias p='podman'
		alias pps='podman ps -a'
		alias pi='podman images'
		alias pc='podman compose'
	end

	if command --search nvim > /dev/null
		alias v='nvim'
	else
		alias v='vim'
	end

	if command --search nix > /dev/null
		alias n='nix'
		alias nd='nix develop -c $SHELL'
	end
end
