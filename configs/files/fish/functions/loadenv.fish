function loadenv
	set -f envfile ".env"

	if not test -f "$envfile"
		echo "No $envfile file in this directory" >&2
		return 1
	end

	# for line in (cat "$envfile" | grep -v '^#')
	# 	set item (string split -m 1 '=' $line)
	# 	set -gx $item[1] $item[2]
	# 	echo "Exported key $item[1]"
	# end

	while read line
		if not string match --quiet --regex '^#|^$' "$line"
			set item (string split -m 1 '=' $line)
			set -gx $item[1] $item[2]
			echo "Exported key $item[1]"
		end
	end < "$envfile"
end

function unloadenv
	set -f envfile ".env"

	if not test -f "$envfile"
		echo "No $envfile file in this directory" >&2
		return 1
	end

	set --erase (cat .env | cut -d '=' -f 1 | xargs)
end
