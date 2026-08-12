function gwtclone --argument-names repo
	if not string match --regex --quiet 'git@.*|https:\/\/.*' $repo
		echo 'Repository does not seem to be a Git URL'
		return 1
	end

	set --local dir (basename $repo | cut -f 1 -d '.')

	# Create the directory.
	mkdir $dir
	cd $dir

	# Clone the repo.
	git clone --bare $repo .bare
	echo 'gitdir: ./.bare' > .git

	# Enable fetching remote branches.
	git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

	# Fetch remote branches.
	git fetch origin
end
