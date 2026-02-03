function pwd_prompt
	set -l in_git_worktree (git rev-parse --is-inside-work-tree 2> /dev/null)

	if test "$in_git_worktree" = "true"
		set -l git_dir (git rev-parse --show-toplevel)
		set -l prefix (string trim --right --chars '/' (git rev-parse --show-prefix))
		set -l repo_and_worktree (string join '/' (basename (dirname $git_dir)) (basename $git_dir))
		set -f sep ''

		if test -n "$prefix"
			set -f sep '/'
		end

		set -l path_string (prompt_pwd (string trim --right --chars '/' $prefix))

		string join '' -- \
			\ue702 \
			' ' \
			$repo_and_worktree \
			$sep \
			$path_string
	else
		string join '' -- \
			\uf07c \
			' ' \
			(prompt_pwd)
	end
end

function fish_prompt
	set -g __fish_git_prompt_show_informative_status true
	set -g __fish_git_prompt_showupstream auto

	string join '' -- \
		(set_color brblue) \
		(pwd_prompt) \
		(set_color brblack) \
		(fish_git_prompt)
	echo -n '> '
end

function fish_right_prompt
	# Move to first line:
	# https://github.com/fish-shell/fish-shell/issues/1706#issuecomment-2430550184
	tput sc; tput cuu1; tput cuf 2

	set -q IN_NIX_SHELL
	and set -f nix_shell (string join ' ' -- \ue843 $IN_NIX_SHELL)

	set -q VIRTUAL_ENV
	and set -f venv (string join ' ' -- \ue73c (string replace -r '.*/' '' -- $VIRTUAL_ENV))

	string join ' ' -- \
		$nix_shell \
		$venv

	tput rc
end
