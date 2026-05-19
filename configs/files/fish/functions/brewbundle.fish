function brewbundle
	set uuid (system_profiler SPHardwareDataType | grep 'Hardware UUID' | awk '{print $3}')

	brew bundle --cleanup --file ~/Development/Projects/github.com/0xd3e/dotfiles/main/Brewfile.$uuid
end
