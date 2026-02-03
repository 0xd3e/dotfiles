function gwtclone --argument-names repo
	if not string match --quiet 'git@*' $repo
		echo 'Repository does not seem to be a Git URL'
		return 1
	end

	set --local dir (basename $repo | cut -f 1 -d '.')

	mkdir $dir
	cd $dir
	git clone --bare $repo .bare
	echo 'gitdir: ./.bare' > .git
end
